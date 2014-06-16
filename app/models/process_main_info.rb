class ProcessMainInfo < ActiveRecord::Base
  self.table_name = 'dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}'
  self.primary_key = 'RowID'

  before_create :assign_id

  alias_attribute :name, :Name

  def instance_id
    self.InstanceID
  end

  def instance_id=(value)
    self.InstanceID = value
  end

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
  end

end