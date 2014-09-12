require 'dvcore/link'

class TaskCard
  attr_reader :instance, :main_info

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true

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
end
