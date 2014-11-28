#encoding: UTF-8

require 'dvcore/link'

class TaskCard
  attr_reader :instance, :main_info

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true
  delegate :create_date, to: :instance
  delegate :change_date, to: :instance


  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.assignment)
      @instance.assign_id
    else
      @instance = instance
    end

    @main_info = TaskCardMainInfo.where(InstanceID: id).first ||
      TaskCardMainInfo.new(InstanceID: id)
  end

  def history
    @history ||= TaskCardHistory.where(InstanceID: id).to_a || []
  end

  def self.all
    Card.where(CardTypeID: CardType.assignment).
      map { |x| TaskCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.assignment).first
    return TaskCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.assignment, InstanceID: id).first
    return TaskCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
    @main_info.save!
    @main_info.performers.each { |x| x.save! }
    @main_info.co_performers.each { |x| x.save! }
    @main_info.acquaintances.each { |x| x.save! }

    DVCore::Link.create_hard_link(
      self.id,
      @main_info.RowID,
      '215B75C2-113A-4D18-B7A1-6D41984B9644',
      @main_info.FileListId)

    DVCore::Link.create_hard_link(
      self.id,
      @main_info.RowID,
      '56E4658F-8E49-43D1-ABE5-F18E2581D9AF',
      @main_info.RefsID)
  end

  def mark_completed(employee, options = {})
    main_info.state = 5
    save!
  end

  def history_data
    cycle_index = history.select { |x| !x.date.nil? && !x.author.nil? }.count { |x| x.decision == :completed }
    cycles = []
    cycle = nil
    history.select { |x| !x.date.nil? }.sort_by { |x| x.date }.reverse.each do |x|
      if cycle.nil? 
        cycle = { index: cycle_index, items: [] }
        cycles << cycle
      end
      item = { 
        author: x.author.display_name, 
        comment: x.comment,
        date: x.date.strftime("%d.%m.%Y %H:%M"), 
        files: [] 
      }
      if (x.decision)
        item[:decision] = I18n.t("task.history.decision.#{x.decision}")
      end
      unless x.files.nil?
        x.files.references.each do |file|
          file_card = FileCard.find(file.file_id)
          unless file_card.file_name.nil?
            item[:files] << { file_id: file_card.id, filename: file_card.file_name }
          end
        end
      end
      cycle[:items] << item
      if x.decision == :completed
        cycle_index = cycle_index - 1
        cycle = nil
      end
    end
    return { cycles: cycles }
  end

  def assignment_tree
    IFP::AssignmentTree.new([IFP::NamedSet.new("Исполнение", [self])], nil)
  end

  @@defaultStateNames = { 1 => "К исполнению", 2 => "На исполнении", 3 => "Исполнено", 4 => "Отозвано",
    5 => "На контроле", 6 => "На доработке", 7 => "Завершено" } 
  @@reviewalStateNames = { 1 => "К рассмотрению", 2 => "На рассмотрении", 3 => "Рассмотрено" }
  @@notifyStateNames = { 1 => "К ознакомлению", 2 => "На ознакомлении", 3 => "Ознакомлен" }

  def self.state_name(state, kind)
    result = @@defaultStateNames[state] || "<не известно>"
    result = @@reviewalStateNames[state] || result if kind == 5 # reviewal
    result = @@notifyStateNames[state] || result if kind == 2 # notify
    return result
  end
end
