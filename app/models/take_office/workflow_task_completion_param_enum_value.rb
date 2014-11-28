module TakeOffice

  class WorkflowTaskCompletionParamEnumValue < ActiveRecord::Base
    self.table_name = "dvtable_{733BFC64-32D2-440B-B8DA-0B82D0674BF0}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :value, :ValueID
    alias_attribute :name, :ValueName

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end
  end
end
