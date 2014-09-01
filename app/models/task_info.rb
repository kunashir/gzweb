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

  def self.random
    TaskInfo.new.send(:init_random)
  end

  def actions
    case
      when is_incdoc_reviewal?
        [ #{action: :comment},
          {action: :redirect},
          {action: :complete, text: 'task.incdoc_reviewal.complete', comments_required: false}]
      when is_memorandum_reviewal?
        [ #{action: :comment},
          {action: :redirect},
          {action: :reject, text: 'task.memorandum_reviewal.reject', comments_required: true},
          {action: :complete, text: 'task.memorandum_reviewal.complete', comments_required: false}]
      when is_approval?
        [ #{action: :comment},
          {action: :complete, text: 'task.complete',
          actions: [
             {action: :approve, text: 'task.approval.approve', comments_required: false},
             {action: :decline, text: 'task.approval.decline', comments_required: true}] }]
      when is_signing?
        [ #{action: :comment},
          {action: :complete, text: 'task.complete',
          actions: [
            {action: :sign, text: 'task.signing.sign', comments_required: false},
            {action: :decline, text: 'task.signing.decline', comments_required: true}] }]
      else 
        [ #{action: :comment},
          {action: :redirect},
          {action: :complete, text: 'task.incdoc_reviewal.complete', comments_required: true}]
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
        else
          task_complete(user, 1, options);
      end
    if result == :folder_remove
      self.destroy
      TasksInfo.recount(user)
    end
    return result
  end

  protected

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

  def task_complete(user, status, options = {})
    TakeOffice::WorkflowTaskCard.find(self.task_id).mark_completed(status, user.employee, options)
    return :folder_remove
  end

end 