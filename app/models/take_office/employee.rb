module TakeOffice

  class Employee < ActiveRecord::Base
    self.table_name = "dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}"
    self.primary_key = "RowID"

    belongs_to :parent, class_name: :Department, primary_key: 'RowID', foreign_key: 'ParentRowID'
    validates :parent, presence: true
    belongs_to :sid, class_name: :SecurityDescriptor, primary_key: 'ID', foreign_key: 'SDID'

    before_create :assign_id
    after_initialize :init

    def self.search(filter)
      ActiveRecord::Base.connection.
        execute_procedure("[dvreport_get_data_{7E898C46-5751-42AC-B55A-1AC867F4B7FA}]", filter).
        map { |x| Employee.new(RowID: x[:RowID], DisplayString: x[:DisplayString]) }
    end

    protected

    def init
      self.NotAvailable ||= false
      self.DisplayString ||= ""
    end

    def assign_id
      self.RowID = SecureRandom.uuid
      self.InstanceID = RefStaff.InstanceID
    end
  end

end