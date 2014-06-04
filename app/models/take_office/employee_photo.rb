module TakeOffice

    class EmployeePhoto < ActiveRecord::Base
      self.table_name = "dvtable_{E722EEE5-64C3-4832-8C32-60BBE53E0A64}"
      self.primary_key = "RowID"

      belongs_to :employee, class_name: :Employee, primary_key: 'RowID', foreign_key: 'ParentRowID'
    end
end