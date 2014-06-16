module DVCore

  class File < ActiveRecord::Base
    self.table_name = "dvsys_files"
    self.primary_key = "FileID"

    before_create :assign_id

    alias_attribute :name, :Name
    alias_attribute :owner_card_id, :OwnerCardID

    belongs_to :binary, class_name: 'DVCore::Binary', primary_key: 'ID', foreign_key: 'BinaryID'
    belongs_to :sid, class_name: 'DVCore::Security', primary_key: 'ID', foreign_key: 'SDID'

    protected 

    def assign_id
      self.FileID ||= SecureRandom.uuid
      self.DateTime ||= Time.now
      self.LastChanged ||= Time.now
      self.StandardAttribs ||= 0
      self.ExtendedAttribs ||= 0
      self.StorageState ||= 0
    end
  end

end