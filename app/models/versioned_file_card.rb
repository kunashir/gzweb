class VersionedFileCard

  attr_reader :instance, :main_info, :versions

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true
  delegate :name, to: :main_info, allow_nil: true
  delegate :name=, to: :main_info, allow_nil: true

  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.versioned_file_card)
      @instance.assign_id
    else
      @instance = instance
    end

    @main_info = VersionedFileCardMainInfo.where(InstanceID: id).first ||
      VersionedFileCardMainInfo.new(InstanceID: id)
    @versions = VersionedFileCardVersion.where(InstanceID: id).to_a ||
      []
  end

  def new_version
    version = VersionedFileCardVersion.new
    version.assign_id

    if @main_info.CurrentID.nil?
      @main_info.CurrentID = version.RowID
    end

    if @main_info.NextVersion.nil?
      @main_info.NextVersion = 0
    end
    @main_info.NextVersion = @main_info.NextVersion + 1
    @main_info.CurrentVersion = @main_info.NextVersion.to_s
    version.Version = @main_info.NextVersion - 1
    version.VersionNumber = @main_info.NextVersion

    @versions << version
    return version
  end

  def self.all
    Card.where(CardTypeID: CardType.versioned_file_card).
      map { |x| VersionedFileCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.versioned_file_card).first
    return VersionedFileCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.versioned_file_card, InstanceID: id).first
    return VersionedFileCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
    @main_info.InstanceID = @instance.InstanceID
    @main_info.save!
    @versions.each do |version|
      version.InstanceID = @instance.InstanceID
      version.save!
    end
  end

end