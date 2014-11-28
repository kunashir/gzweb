module TakeOffice

  class WorkflowTaskCurrentPerformer < ActiveRecord::Base
    self.table_name = "dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}"
    self.primary_key = "RowID"

    belongs_to :performer, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'PerformerID'
    belongs_to :deputy_for, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'DeputyFor'

    before_create :assign_fields

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end
  end
end
