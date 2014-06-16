require 'dvcore/security'

module TakeOffice

  class Shortcut < ActiveRecord::Base
    self.table_name = "dvtable_{EB1D77DD-45BD-4A5E-82A7-A0E3B1EB1D74}"
    self.primary_key = "RowID"

    belongs_to :parent, class_name: :Folder, primary_key: 'RowID', foreign_key: 'ParentRowID'
    before_create :assign_id

    alias_attribute :card_id, :CardID
    alias_attribute :hard_card_id, :HardCardID

    protected

    def assign_id
      self.RowID = SecureRandom.uuid
    end
    
  end

end