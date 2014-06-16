class ProcessVariableValue < ActiveRecord::Base
  self.table_name = 'dvtable_{52F01448-151C-4D4B-B18E-E80A06B5A581}'
  self.primary_key = 'RowID'

  before_create :assign_id

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
  end

end