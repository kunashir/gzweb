class CardDate < ActiveRecord::Base
	self.table_name = "dvsys_instances_date"
	self.primary_key = "InstanceID"

	belongs_to :card, class_name: :Card, primary_key: 'InstanceID', foreign_key: 'InstanceID'

  alias_attribute :create_date, :CreationDateTime
  alias_attribute :change_date, :ChangeDateTime
end