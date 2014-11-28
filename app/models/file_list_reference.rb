class FileListReference < ActiveRecord::Base
  self.table_name = 'dvtable_{E962AC85-0F53-4439-A1CD-171E46C3EF91}'
  self.primary_key = 'RowID'

  before_create :assign_id

  alias_attribute :file_id, :CardFileID
  alias_attribute :id, :RowID

  def file
    @file ||= load_file
  end

  def load_file
    FileCard.find(file_id)
  end

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
    self.CanDelete ||= true
    self.CanModify ||= true
    self.CanCheckout ||= true
  end

end