class CardDate < ActiveRecord::Base
	self.table_name = "dvsys_instances_date"
	self.primary_key = "InstanceID"

	belongs_to :card, class_name: :Card, primary_key: 'InstanceID', foreign_key: 'InstanceID'

  before_save :assign_required_attributes

  alias_attribute :create_date, :CreationDateTime
  alias_attribute :change_date, :ChangeDateTime

  protected

  def assign_required_attributes
    self.Timestamp ||= "\x00"
  end
end