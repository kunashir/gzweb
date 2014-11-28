module TakeOffice

  class WorkflowTaskCompletionParam < ActiveRecord::Base
    self.table_name = "dvtable_{01AE4B60-5174-4304-B7D6-3F5ACAE357E1}"
    self.primary_key = "RowID"

    has_many :enum_values, class_name: 'TakeOffice::WorkflowTaskCompletionParamEnumValue', primary_key: 'RowID', foreign_key: 'ParentRowID'

    before_create :assign_fields

    alias_attribute :value, :SelectedValue
    alias_attribute :name, :SelectionName

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end
  end
end
