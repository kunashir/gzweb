#encoding: UTF-8

class TaskInfo < CacheBase

  after_initialize :init_fields
  belongs_to :user
  has_many :task_files

  def init_fields
    self.task_id ||= "00000000-0000-0000-0000-000000000000"
  end

  def ==(other)
    other.class == TaskInfo && task_id == other.task_id
  end

  def assignment
    @assignment ||= (assignment_id.nil? ? nil : TaskCard.find(assignment_id))
  end

  def self.random
    TaskInfo.new.send(:init_random)
  end

  def actions
    case
      when is_incdoc_reviewal?
        [ {action: :redirect},
          {action: :complete, text: 'task.incdoc_reviewal.complete', comments_required: false}]
      when is_memorandum_reviewal?
        [ {action: :redirect},
          {action: :complete, text: 'task.memorandum_reviewal.complete', comments_required: false},
          {action: :reject, text: 'task.memorandum_reviewal.reject', comments_required: true}]
      when is_approval?
        [ {action: :redirect},
          {action: :approve, text: 'task.approval.approve', comments_required: false},
          {action: :decline, text: 'task.approval.decline', comments_required: true}]
      when is_signing?
        [ {action: :redirect},
          {action: :sign, text: 'task.signing.sign', comments_required: false},
          {action: :decline, text: 'task.signing.decline', comments_required: true}]
      when is_inform_task?
        [ {action: :redirect},
          {action: :complete, text: 'task.inform_task.complete'} ]
      when is_accept_task?
        [ {action: :accept, text: 'task.accept_task.accept', comments_required: false},
          {action: :reject, text: 'task.accept_task.reject', comments_required: true}]
      else 
        [ {action: :comment},
          {action: :redirect},
          {action: :complete, text: 'task.complete', comments_required: true}]
    end
  end

  def perform(action, user, options = {})
    result = 
      case
        when is_incdoc_reviewal?
          task_complete(user, 1, options);
        when is_memorandum_reviewal?
          case action.to_sym
            when :complete
              task_complete(user, 1, options);
            when :reject
              task_complete(user, 2, options);
          end
        when is_approval?
          case action.to_sym
            when :approve
              task_complete(user, 1, options);
            when :decline
              task_complete(user, 2, options);
          end
        when is_signing?
          case action.to_sym
            when :sign
              task_complete(user, 1, options);
            when :decline
              task_complete(user, 2, options);
          end
        when is_accept_task?
          case action.to_sym
            when :accept
              task_complete(user, 1, options);
            when :reject
              task_complete(user, 2, options);
          end
        else
          task_complete(user, 1, options);
      end
    if result == :folder_remove
      self.destroy
      TasksInfo.recount(user)
    end
    if is_accept_task? && action.to_sym == :accept
      result = build_parent_task_response || { result: result }
    else
      result = { result: result }
    end
    return result
  end

  def history
    return { cycles: [] } if assignment.nil?
    return assignment.history_data
  end

  def assignment_tree
    IFP::AssignmentTreeBuilder.build(self.parent_document_id || self.assignment_id)
  end

  # protected

  def self.rnd
    @@rnd ||= Random.new
  end

  def init_random
    self.task_id = SecureRandom.uuid
    self.parent_document = "#{TaskInfo.rnd.rand(1000)}/201#{3 + TaskInfo.rnd.rand(2)}"
    self.author_name = RandomHelper.persons[TaskInfo.rnd.rand(RandomHelper.persons.count)]
    self.subject = RandomHelper.subjects[TaskInfo.rnd.rand(RandomHelper.subjects.count)]
    self.content = RandomHelper.contents[TaskInfo.rnd.rand(RandomHelper.contents.count)]
    self.date = 
      case TaskInfo.rnd.rand(4)
        when 0
          Time.now - 2.years + TaskInfo.rnd.rand(364).days + TaskInfo.rnd.rand(24*60*60).seconds
        when 1
          Time.now - 1.years + TaskInfo.rnd.rand(334).days + TaskInfo.rnd.rand(24*60*60).seconds
        when 2
          Time.now - 1.month + TaskInfo.rnd.rand(27).days + TaskInfo.rnd.rand(24*60*60).seconds
        else
          Time.now - 1.week + TaskInfo.rnd.rand(6).days + TaskInfo.rnd.rand(24*60*60).seconds
        end
    self.deadline = 
      case TaskInfo.rnd.rand(5)
        when 0
          Time.now - 1.week + TaskInfo.rnd.rand(6).days + TaskInfo.rnd.rand(24*60*60).seconds
        when 1
          Time.now + TaskInfo.rnd.rand(24*60*60).seconds
        when 2
          Time.now + 1.day + TaskInfo.rnd.rand(2*24*60*60).seconds
        when 3
          Time.now + 3.day + TaskInfo.rnd.rand(24).days + TaskInfo.rnd.rand(24*60*60).seconds
        else
          nil
        end
    self.delegated_to = 
      case TaskInfo.rnd.rand(2)
        when 0
            RandomHelper.persons[TaskInfo.rnd.rand(RandomHelper.persons.count)]
        else
          nil
      end
    self
  end

  def is_incdoc_reviewal?
    'incdoc_reviewal' == self.kind.try(:to_s)
  end

  def is_memorandum_reviewal?
    'memorandum_reviewal' == self.kind.try(:to_s)
  end

  def is_approval?
    'to_approve' == self.folder.try(:to_s)
  end

  def is_signing?
    'to_sign' == self.folder.try(:to_s)
  end

  def is_inform_task?
    'informational' == self.folder.try(:to_s)
  end

  def is_accept_task?
    'to_accept' == self.folder.try(:to_s)
  end

  def task_complete(user, status, options = {})
    TakeOffice::WorkflowTaskCard.find(self.task_id).mark_completed(status, user.employee, options)
    return :folder_remove
  end

  def build_parent_task_response
    task = TakeOffice::WorkflowTaskCard.find(self.task_id)
    return nil if assignment.nil?
    return nil if assignment.main_info.author != assignment.main_info.controller
    return nil if assignment.main_info.parent_task.nil?
    parent_task_info = TaskInfo.where(task_id: assignment.main_info.parent_task.id).first
    retirn nil if parent_task_info.nil?
    last_comment = assignment.history.
      select { |x| !x.Date.nil? }.
      select { |x| task.performing.actual_end_date.nil? || x.Date <= task.performing.actual_end_date }.
      sort_by { |x| x.Date }.
      reverse.
      select { |x| !x.comment.nil? }.
      first.try(:comment) || ''
    files = assignment.history.
      select { |x| !x.Date.nil? }.
      select { |x| task.performing.actual_end_date.nil? || x.Date <= task.performing.actual_end_date }.
      sort_by { |x| x.Date }.
      reverse.
      select { |x| !x.files.nil? && x.files.references.length > 0 }.
      first.try(:files).try(:references).
      select { |x| !x.file.nil? }.
      map { |x| { id: x.file.id, file_name: x.file.file_name } }
    return { result: :show_parent, parent_id: parent_task_info.id, comment: last_comment, files: files }
  end

end 