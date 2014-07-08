module TakeOffice

  class WorkflowTaskPerforming < ActiveRecord::Base
    self.table_name = "dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :actual_end_date, :ActualEndDate

    def state
      unless self.TaskState.nil?
        @@states[self.TaskState + 1]
      else
        nil
      end
    end

    def state=(value)
      state = @@states.index(value)
      unless state.nil?
        self.TaskState = state - 1
      else
        self.TaskState = nil
      end
      return self.state
    end

    def completed_employee
      @completed_employee ||= Employee.find(self.CompletedEmployeeID)
    end

    def completed_employee=(value)
      if value.nil?
        self.CompletedEmployeeID = nil
      else
        self.CompletedEmployeeID = value.id
      end
      @completed_employee = value
    end

    protected

    def assign_fields
      self.TaskState ||= -1
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end

    private

    @@states = [:unknown, :inactive, :to_perform, :to_begin, :in_process,
                :postponed, :completed, :rejected, :recalled, :delegated_to_begin,
                :delegated_in_process, :delegated_postponed, :delegated_to_perform,
                :delegated_returning, :delegated_returned]
  end
end