require 'dvcore/link'

class FileListCard

  attr_reader :instance, :references

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true

  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.file_list)
      @instance.assign_id
    else
      @instance = instance
    end

    @references = FileListReference.where(InstanceID: id).to_a || []
  end

  def add_file(file)
    reference = FileListReference.new
    reference.InstanceID = id
    if file.is_a? FileCard
      reference.file_id = file.id
    else
      reference.file_id = file
    end
    @references << reference
    return reference
  end

  def self.all
    Card.where(CardTypeID: CardType.file_list).
      map { |x| FileListCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.file_list).first
    return FileListCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.file_list, InstanceID: id).first
    return FileListCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
    @references.each { |x| 
      x.save! 
      DVCore::Link.create_hard_link(
        self.id,
        x.id,
        'F8509420-CF86-4166-8D91-9388D79DDD86',
        x.file_id)
    }
  end

end