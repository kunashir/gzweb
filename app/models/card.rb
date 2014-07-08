require 'dvcore/security'

class Card < ActiveRecord::Base
  self.table_name = 'dvsys_instances'
  self.primary_key = 'InstanceID'

  validates :card_type, presence: true

  belongs_to :card_type, class_name: :CardType, primary_key: 'CardTypeID', foreign_key: 'CardTypeID' 
  belongs_to :sid, class_name: 'DVCore::Security', primary_key: 'ID', foreign_key: 'SDID'
  belongs_to :topic, class_name: :Topic, primary_key: 'ID', foreign_key: 'TopicID'
  has_one :card_date, class_name: :CardDate, primary_key: 'InstanceID', foreign_key: 'InstanceID'

  delegate :create_date, to: :card_date, allow_nil: true
  delegate :change_date, to: :card_date, allow_nil: true

  before_create :assign_id
  before_save :assign_card_type_sid
  after_save :assign_change_date

  alias_attribute :id, :InstanceID
  alias_attribute :topic_index, :TopicIndex
  alias_attribute :parent_id, :ParentID
  alias_attribute :timestamp, :Timestamp
  alias_attribute :order, :Order
  alias_attribute :archive_state, :ArchiveState
  alias_attribute :description, :Description

  def initialize(*args)
    super
    self.TopicIndex = 0
    self.ParentID = "00000000-0000-0000-0000-000000000000"
    self.Order = 0
    self.ArchiveState = 0
    self.Description = ""
  end

  def self.copy_card(card_id)
    connection = ActiveRecord::Base.connection
    result = connection.exec_query "DECLARE @id uniqueidentifier;EXEC dvsys_card_copy '00000000-0000-0000-0000-000000000000','#{card_id}', @id OUTPUT;SELECT @id as ID"
    return result.first["ID"]
  end

  def is_deleted
    !!self.Deleted
  end

  def is_deleted=(value)
    self.Deleted = value ? true : nil
  end

  alias_method :deleted?, :is_deleted

  def is_template
    !!self.Template
  end

  def is_template=(value)
    self.Template = value ? true: nil
  end

  alias_method :template?, :is_template

  def assign_id
    self.InstanceID ||= SecureRandom.uuid
  end

  protected

  def assign_card_type_sid
    self.sid ||= self.card_type.sid
    self.timestamp ||= "\x00"
  end

  def assign_change_date
    if self.card_date.nil?
      self.card_date = CardDate.new(card: self)
      self.card_date.create_date = Time.zone.now + Time.zone_offset(Time.now.zone)
      self.card_date.change_date = self.create_date
    else
      self.card_date.change_date = Time.zone.now + Time.zone_offset(Time.now.zone)
    end 
    self.card_date.save!
  end
end