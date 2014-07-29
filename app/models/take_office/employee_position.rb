module TakeOffice

    class EmployeePosition < ActiveRecord::Base
      self.table_name = "dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}"
      self.primary_key = "RowID"

      alias_attribute :name, :Name
    end
end