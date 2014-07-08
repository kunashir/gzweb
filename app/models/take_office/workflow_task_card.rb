#encoding: UTF-8

module TakeOffice
  
  class WorkflowTaskCard
    attr_reader :instance, :main_info, :performing, :log, :comments

    delegate :id, to: :instance, allow_nil: true
    delegate :sid, to: :instance, allow_nil: true
    delegate :sid=, to: :instance, allow_nil: true
    delegate :description, to: :instance, allow_nil: true
    delegate :description=, to: :instance, allow_nil: true

    def initialize(instance = nil)
      if instance.nil?
        @instance = Card.new(CardTypeID: CardType.workflow_task)
        @instance.assign_id
      else
        @instance = instance
      end

      @main_info = WorkflowTaskMainInfo.where(InstanceID: id).first ||
        WorkflowTaskMainInfo.new(InstanceID: id)

      @performing = WorkflowTaskPerforming.where(InstanceID: id).first ||
        WorkflowTaskPerforming.new(InstanceID: id)

      @log = WorkflowTaskLog.where(InstanceID: id).to_a || []
      
      @comments = WorkflowTaskComment.where(InstanceID: id).to_a || []
    end

    def self.all
      Card.where(CardTypeID: CardType.workflow_task).
        map { |x| WorkflowTaskCard.new(x) }
    end

    def self.first
      instance = Card.where(CardTypeID: CardType.workflow_task).first
      return WorkflowTaskCard.new(instance) unless instance.nil?
      return nil
    end

    def self.find(id)
      instance = Card.where(CardTypeID: CardType.workflow_task, InstanceID: id).first
      return WorkflowTaskCard.new(instance) unless instance.nil?
      return nil
    end

    def save!
      ActiveRecord::Base.transaction do
        instance.save!
        main_info.save!
        performing.save!
        log.each { |x| x.save! }
        comments.each { |x| x.save! }
      end
      self
    end

    def mark_completed(employee, options = {})
      now = Time.now + Time.zone_offset(Time.now.zone)
      options = options.symbolize_keys

      self.description = "#{main_info.Name}, Завершено"
      performing.state = :completed
      performing.completed_employee = employee
      performing.actual_end_date = now

      comment_text = options[:comments]
      unless comment_text.blank?
        comment = WorkflowTaskComment.new(InstanceID: id)
        comment.text = comment_text
        comment.is_report = true
        comment.created_by = employee 
        comment.creation_date = now
        comments << comment

        log_item = WorkflowTaskLog.new(InstanceID: id)
        log_item.action = :add_comment
        log_item.action_by = employee
        log_item.action_date = now
        log << log_item
      end

      log_item = WorkflowTaskLog.new(InstanceID: id)
      log_item.action = :task_finished
      log_item.action_by = employee
      log_item.action_date = now
      log << log_item

      save!
    end
  end
end