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
        [{action: :complete, text: 'task.incdoc_reviewal.complete', comments_required: false}]
      else []
    end
  end

  def perform(action, user, options = {})
    # case
    #   when is_incdoc_reviewal?
        incdoc_reviewal_complete(user, options)
    # end
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

  def incdoc_reviewal_complete(user, options = {})
    TakeOffice::WorkflowTaskCard.find(self.task_id).mark_completed(user.employee, options)

    self.destroy
    TasksInfo.recount(user)
    
    :folder_remove
  end
end 