require 'employee'

module TakeOffice

  class WorkflowTaskMainInfo < ActiveRecord::Base
    self.table_name = "dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :name, :Name

    def performer_files
      @performer_files ||=
        case
          when self.PerformerFilesID.nil?
            nil
          else
            FileListCard.find(self.PerformerFilesID)
        end
    end

    def performer_files=(value)
      if !value.nil? && value.respond_to?(:id)
        self.PerformerFilesID = value.id
        @performer_files = value
      else
        self.PerformerFilesID = nil
        @performer_file = nil
      end
    end

    alias_method :old_save!, :save!

    def save!
      self.old_save!
      unless performer_files.nil?
        performer_files.save!
        DVCore::Link.create_hard_link(
          self.InstanceID,
          self.id,
          '7DB089A9-9688-44B5-AADD-B97C7F34E199',
          performer_files.id)
      end
    end

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end
  end
end