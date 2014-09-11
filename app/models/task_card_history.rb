require 'take_office/employee'
require 'take_office/workflow_task_card'

class TaskCardHistory < ActiveRecord::Base
  self.table_name = "dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}"
  self.primary_key = "RowID"

  before_create :assign_id
  belongs_to :author, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Executer'

  alias_attribute :date, :Date
  alias_attribute :comment, :Comment

  def decision
    unless self.Decision.nil?
      @@decisions[self.Decision - 1]
    else
      nil
    end
  end

  def decision=(value)
    decision = @@decisions.index(value)
    unless decision.nil?
      self.Decision = decision + 1
    else
      self.Decision = nil
    end
    return self.Decision
  end

  def files
    @files ||= FileListCard.find(self.Files)
  end

  def files=(value)
    @files = value
    self.Files = @files.try(:id)
  end

  def task
    @task ||= TakeOffice::WorkflowTaskCard.where(InstanceID: self.TaskID).first
  end

  def task=(value)
    @task = value
    self.TaskID = @task.try(:id)
  end

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
    self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
  end

  private

  @@decisions = [:reviewed, :improve_needed, :finished, :recalled, :accepted, :completed]

end