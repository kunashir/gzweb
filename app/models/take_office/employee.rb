module TakeOffice

  class Employee < ActiveRecord::Base
    self.table_name = "dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}"
    self.primary_key = "RowID"
    @@quick_performers = nil

    belongs_to :parent, class_name: :Department, primary_key: 'RowID', foreign_key: 'ParentRowID'
    validates :parent, presence: true
    belongs_to :sid, class_name: :SecurityDescriptor, primary_key: 'ID', foreign_key: 'SDID'
    has_many :photos, class_name: :EmployeePhoto, primary_key: 'RowID', foreign_key: 'ParentRowID'
    belongs_to :position, class_name: :EmployeePosition, primary_key: 'RowID', foreign_key: 'Position'

    before_create :assign_id
    after_initialize :init

    alias_attribute :account_sid, :AccountSID

    def self.search(filter)
      ActiveRecord::Base.connection.
        execute_procedure("[dvreport_get_data_{7E898C46-5751-42AC-B55A-1AC867F4B7FA}]", filter).
        map { |x| Employee.find(x[:RowID]) }
    end

    alias_attribute :id, :RowID
    alias_attribute :display_name, :DisplayString
    alias_attribute :first_name, :FirstName
    alias_attribute :last_name, :LastName
    alias_attribute :middle_name, :MiddleName

    def has_photo?
      photos.any?
    end

    def self.quick_performers
      load_quick_performers_ids
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

    def self.load_quick_performers_ids
      return unless @@quick_performers.nil?
      ids = []
      demo_data = YAML.load_file("#{Rails.root}/config/demo.yml")
      unless demo_data.nil?
        env_data = demo_data[Rails.env]
        unless env_data.nil?
          unless env_data["quick"].nil?
            ids = env_data["quick"]
          end
        end
      end
      @@quick_performers = []
      ids.each { |id| 
        employee = TakeOffice::Employee.where(RowID: id).first
        @@quick_performers << employee unless employee.nil?
      }
    end

  end

end