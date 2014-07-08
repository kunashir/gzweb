require 'employee'

module TakeOffice

  class WorkflowTaskMainInfo < ActiveRecord::Base
    self.table_name = "dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :name, :Name

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end
  end
end