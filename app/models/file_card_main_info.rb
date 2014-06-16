class FileCardMainInfo < ActiveRecord::Base
  self.table_name = 'dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}'
  self.primary_key = 'InstanceID'

  before_create :assign_id
  belongs_to :author, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Author'

  alias_attribute :file_name, :FileName
  alias_attribute :id, :RowID

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.VersioningType = 1
  end

end