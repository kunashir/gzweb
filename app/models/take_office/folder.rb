require 'dvcore/security'

module TakeOffice

  class Folder < ActiveRecord::Base
    self.table_name = "dvtable_{FE27631D-EEEA-4E2E-A04C-D4351282FB55}"
    self.primary_key = "RowID"

    before_create :assign_id
    belongs_to :parent, class_name: :Folder, primary_key: 'RowID', foreign_key: 'ParentTreeRowID'
    has_many :children, class_name: :Folder, primary_key: 'RowID', foreign_key: 'ParentTreeRowID'
    has_many :shortcuts, class_name: :Shortcut, primary_key: 'RowID', foreign_key: 'ParentRowID'
    belongs_to :sid, class_name: 'DVCore::Security', primary_key: 'ID', foreign_key: 'SDID'

    alias_attribute :id, :RowID
    alias_attribute :name, :Name

    def add_hard_shortcut(card_id)
      shortcut = shortcuts.new()
      shortcut.InstanceID = self.InstanceID
      shortcut.hard_card_id = card_id
      shortcut.save!
    end

    protected

    def assign_id
      self.RowID = SecureRandom.uuid
    end
    
  end

end