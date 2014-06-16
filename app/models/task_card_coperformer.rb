require 'take_office/employee'

class TaskCardCoperformer < ActiveRecord::Base
  self.table_name = "dvtable_{0CE329FC-33E8-4D10-B717-562B7FC1208D}"
  self.primary_key = "RowID"

  before_create :assign_id
  belongs_to :assignee, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Coperformer'
  belongs_to :main_info, class_name: :TaskCardMainInfo, primary_key: 'RowID', foreign_key: 'ParentRowID'

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
    self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
  end

end