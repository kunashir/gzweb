require 'take_office/employee'

class TaskCardMainInfo < ActiveRecord::Base
  self.table_name = "dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}"
  self.primary_key = "RowID"

  before_create :assign_id
  belongs_to :author, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Author'
  belongs_to :registrator, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Registrator'
  belongs_to :controller, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Controller'
  has_many :performers, class_name: :TaskCardAssignee, primary_key: 'RowID', foreign_key: 'ParentRowID'
  has_many :co_performers, class_name: :TaskCardCoperformer, primary_key: 'RowID', foreign_key: 'ParentRowID'
  has_many :acquaintances, class_name: :TaskCardAcquaintance, primary_key: 'RowID', foreign_key: 'ParentRowID'

  alias_attribute :content, :Content
  alias_attribute :deadline, :Deadline
  alias_attribute :for_acquaintance, :ForAcquaintance
  alias_attribute :private_access, :OnlyPrivateAccess 
  alias_attribute :registration_date, :RegistrationDate

  def state
    unless self.State.nil?
      @@states[self.State - 1]
    else
      nil
    end
  end

  def state=(value)
    state = @@states.index(value)
    unless state.nil?
      self.State = state + 1
    else
      self.State = nil
    end
    return self.state
  end

  def type
    unless self.Type.nil?
      @@types[self.Type - 1]
    else
      nil
    end
  end

  def type=(value)
    type = @@types.index(value)
    unless type.nil?
      self.Type = type + 1
    else
      self.Type = nil
    end
    return self.type
  end

  def file_list
    @file_list ||= FileListCard.find(self.FileListId)
  end

  def file_list=(value)
    @file_list = value
    self.FileListId = @file_list.try(:id)
  end

  def refs_list
    @refs_list ||= RefListCard.find(self.RefsID)
  end

  def refs_list=(value)
    @refs_list = value
    self.RefsID = @refs_list.try(:id)
  end

  def add_performer(value)
    performer = performers.new(InstanceID: self.InstanceID)
    performer.assignee = value
    return performer
  end

  def add_co_performer(value)
    co_performer = co_performers.new(InstanceID: self.InstanceID)
    co_performer.assignee = value
    return co_performer
  end

  def add_acquaintance(value)
    acquaintance = acquaintances.new(InstanceID: self.InstanceID)
    acquaintance.assignee = value
    return acquaintance
  end

  def state_name
    TaskCard.state_name(self.State, self.Type)
  end

  def assignee_task
    @assignee_task ||= load_assignee_task
  end

  def load_assignee_task
    return nil if self.AssigneeTaskId.nil?
    instance = Card.find(self.AssigneeTaskId)
    return nil if instance.nil?
    return nil if instance.CardTypeID != CardType.workflow_task_id
    return instance.card
  end

  def parent_task
    @parent_task ||= load_parent_task
  end

  def load_parent_task
    return nil if self.ParentTaskID.nil?
    instance = Card.find(self.ParentTaskID)
    return nil if instance.nil?
    return nil if instance.CardTypeID != CardType.workflow_task_id
    return instance.card
  end

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.for_acquaintance ||= false
    self.private_access ||= false
    self.state ||= :not_started
    self.type ||= :task
    self.registration_date ||= Time.now + Time.zone_offset(Time.now.zone)
    self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
    self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
  end

  private

  @@states = [:not_started, :executing, :finished, :recalled, :controlling, :improving, :closed_author]
  @@types = [:task, :notify, :approval, :signing, :reviewal, :prepare_for_signing, :acquintance]

end