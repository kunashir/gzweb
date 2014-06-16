class RefListCard

  attr_reader :instance

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true

  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.refs_list)
      @instance.assign_id
    else
      @instance = instance
    end
  end

  def self.all
    Card.where(CardTypeID: CardType.refs_list).
      map { |x| RefListCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.refs_list).first
    return RefListCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.refs_list, InstanceID: id).first
    return RefListCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
  end

end