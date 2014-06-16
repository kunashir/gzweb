require 'dvcore/file'

class VersionedFileCardVersion < ActiveRecord::Base
  self.table_name = 'dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}'
  self.primary_key = 'InstanceID'

  belongs_to :author, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'AuthorID'

  before_create :assign_id

  def file
    @file = @file || DVCore::File.find(self.FileID)
  end

  def file=(value)
    @file = value
    unless @file.nil?
      self.FileID = @file.FileID
    else
      self.FileID = nil
    end
  end

  def assign_id
    self.RowID ||= SecureRandom.uuid
  end

end