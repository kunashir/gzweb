require 'dvcore/link'

class FileCard

  attr_reader :instance, :main_info

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true
  delegate :file_name, to: :main_info, allow_nil: true
  delegate :file_name=, to: :main_info, allow_nil: true
  delegate :author, to: :main_info, allow_nil: true
  delegate :author=, to: :main_info, allow_nil: true

  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.file_card)
      @instance.assign_id
    else
      @instance = instance
    end

    @main_info = FileCardMainInfo.where(InstanceID: id).first ||
      FileCardMainInfo.new(InstanceID: id)
  end

  def versioned_file
    @versioned_file ||= VersionedFileCard.find(@main_info.FileID)
  end

  def versioned_file=(value)
    @versioned_file = value
    @main_info.FileID = @versioned_file.try(:id)
  end

  def self.all
    Card.where(CardTypeID: CardType.file_card).
      map { |x| FileCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.file_card).first
    return FileCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.file_card, InstanceID: id).first
    return FileCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
    @main_info.InstanceID = @instance.InstanceID
    @main_info.save!

    DVCore::Link.create_hard_link(
      self.id,
      @main_info.id,
      'BBBA25A6-537F-4753-B429-58231FEA1784',
      versioned_file.try(:id))
  end

end