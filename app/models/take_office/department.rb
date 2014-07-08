module TakeOffice

  class Department < ActiveRecord::Base
    scope :root, -> { where(ParentTreeRowID: '00000000-0000-0000-0000-000000000000') }

    self.table_name = "dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}"
    self.primary_key = "RowID"

    belongs_to :parent, class_name: :Department, primary_key: 'RowID', foreign_key: 'ParentTreeRowID'
    has_many :children, class_name: :Department, primary_key: 'RowID', foreign_key: 'ParentTreeRowID'
    has_many :employees, class_name: :Employee, primary_key: 'RowID', foreign_key: 'ParentRowID'
    belongs_to :sid, class_name: :SecurityDescriptor, primary_key: 'ID', foreign_key: 'SDID'

    before_create :assign_id


    protected

    def assign_id
      self.RowID = SecureRandom.uuid
      self.InstanceID = RefStaff.InstanceID
    end
  end

end
