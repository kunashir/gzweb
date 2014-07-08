module TakeOffice

  class Employee < ActiveRecord::Base
    self.table_name = "dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}"
    self.primary_key = "RowID"
    @@quick_performers = []

    belongs_to :parent, class_name: :Department, primary_key: 'RowID', foreign_key: 'ParentRowID'
    validates :parent, presence: true
    belongs_to :sid, class_name: :SecurityDescriptor, primary_key: 'ID', foreign_key: 'SDID'
    has_many :photos, class_name: :EmployeePhoto, primary_key: 'RowID', foreign_key: 'ParentRowID'

    before_create :assign_id
    after_initialize :init

    alias_attribute :account_sid, :AccountSID

    def self.search(filter)
      ActiveRecord::Base.connection.
        execute_procedure("[dvreport_get_data_{7E898C46-5751-42AC-B55A-1AC867F4B7FA}]", filter).
        map { |x| Employee.new(RowID: x[:RowID], DisplayString: x[:DisplayString]) }
    end

    def id
      self.RowID
    end

    def has_photo?
      photos.any?
    end

    def self.quick_performers_ids=(ids)
      @@quick_performers = []
      ids.each { |id| 
        employee = TakeOffice::Employee.where(RowID: id).first
        @@quick_performers << employee unless employee.nil?
      }
    end

    def self.quick_performers
      return @@quick_performers unless @@quick_performers.nil? || @@quick_performers.blank?
      return TakeOffice::Employee.all.take(6)
    end

    def self.find(id)
      self.where(RowID: id).first
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