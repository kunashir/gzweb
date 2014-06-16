require 'take_office/employee'

class TaskCardAcquaintance < ActiveRecord::Base
  self.table_name = "dvtable_{1E3CE215-62F4-4818-B860-E7C0EEE68254}"
  self.primary_key = "RowID"

  before_create :assign_id
  belongs_to :assignee, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'ForAcquaintanceAssignee'
  belongs_to :main_info, class_name: :TaskCardMainInfo, primary_key: 'RowID', foreign_key: 'ParentRowID'

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
    self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
  end

end