module TakeOffice

  class WorkflowTaskLog < ActiveRecord::Base
    self.table_name = "dvtable_{96909C05-27C2-4E37-9770-A4D0D2C10CB8}"
    self.primary_key = "RowID"

    before_create :assign_fields

    alias_attribute :action_date, :ActionDate

    def action
      unless self.Action.nil?
        @@actions[self.Action]
      else
        nil
      end
    end

    def action=(value)
      action = @@actions.index(value)
      unless action.nil?
        self.Action = action
      else
        self.Action = nil
      end
      return self.action
    end

    def action_by
      @action_by ||= Employee.find(self.ActionBy)
    end

    def action_by=(value)
      if value.nil?
        self.ActionBy = nil
      else
        self.ActionBy = value.id
      end
      @action_by = value
    end

    protected

    def assign_fields
      self.RowID ||= SecureRandom.uuid
      self.ParentRowID ||= '00000000-0000-0000-0000-000000000000'
      self.ParentTreeRowID ||= '00000000-0000-0000-0000-000000000000'
    end

    private

    @@actions = [:none, :task_open, :task_close, :add_document, :modify_document,
                 :document_open, :creating_version, :change_status, :time_change,
                 :add_comment, :doc_add_comment, :percent_change, :task_recalled,
                 :task_rejected, :task_finished, :perform_sent, :being_delegated,
                 :delegated_return, :performer_changed, :child_task_created,
                 :child_task_completed, :work_duration_change]
  end
end
