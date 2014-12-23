#encoding: UTF-8

module TakeOffice

  class WorkflowTaskProperty < ActiveRecord::Base
    self.table_name = "dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}"
    self.primary_key = "RowID"

    alias_attribute :name, :Name
    alias_attribute :value, :Value
  end
end