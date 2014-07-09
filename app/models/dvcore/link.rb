module DVCore

  class Link < ActiveRecord::Base
    self.table_name = "dvsys_links"
    self.primary_key = "RowGuid"

    alias_attribute :source_card_id, :SourceCardID
    alias_attribute :destination_card_id, :DestinationCardID
    alias_attribute :field_id, :FieldID
    alias_attribute :row_id, :RowID
    alias_attribute :id, :RowGuid
    alias_attribute :type, :Type

    before_create :assign_id

    def assign_id
      self.id ||= SecureRandom.uuid
      self.type ||= 1
      self.Timestamp ||= "\x00"
    end

    def self.create_hard_link(source_card_id, source_row_id, source_field_id, destination_card_id)
      link = DVCore::Link.where(
        RowID: source_row_id, 
        FieldID: source_field_id).first

      if !link.nil? && (destination_card_id.nil? || link.destination_card_id != destination_card_id)
        link.destroy!
        link = nil
      end

      if link.nil? && !destination_card_id.nil?
        DVCore::Link.create!(
          RowID: source_row_id, 
          FieldID: source_field_id,
          SourceCardID: source_card_id,
          DestinationCardID: destination_card_id,
          Type: 2)
      end
    end

  end

end