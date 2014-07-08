module TakeOffice

  class WorkflowTaskComment < ActiveRecord::Base
    self.table_name = "dvtable_{9F3D8474-49A3-43DC-9D2B-59E82CC8F267}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :creation_date, :CreationDate
    alias_attribute :is_report, :IsReport
    alias_attribute :text, :Comment

    def report?
      self.is_report || false
    end

    def created_by
      @created_by ||= Employee.find(self.CreatedBy)
    end

    def created_by=(value)
      if value.nil?
        self.CreatedBy = nil
      else
        self.CreatedBy = value.id
      end
      @created_by = value
    end

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end

  end
end
