class VersionedFileCardMainInfo < ActiveRecord::Base
  self.table_name = 'dvtable_{2FDE03C2-FF87-4E42-A8C2-7CED181977FB}'
  self.primary_key = 'InstanceID'

  before_create :assign_id

  alias_attribute :name, :Name

  def assign_id
    self.RowID ||= SecureRandom.uuid
  end

end