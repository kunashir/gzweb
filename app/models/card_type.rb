require 'dvcore/security'

class CardType < ActiveRecord::Base
  self.table_name = 'dvsys_carddefs'
  self.primary_key = 'CardTypeID'

  belongs_to :sid, class_name: 'DVCore::Security', primary_key: 'ID', foreign_key: 'SDID'

  before_save :assign_required_attributes

  def self.assignment
    self.find('FFF11133-DFC4-4CD6-A2D4-BD242E2A4670')
  end

  def self.ref_staff
    self.find('6710B92A-E148-4363-8A6F-1AA0EB18936C')
  end

  def self.file_card
    self.find('2BBD0A41-265E-4FF8-82D6-C6342F34B1AF')
  end

  def self.versioned_file_card
    self.find('6E39AD2B-E930-4D20-AAFA-C2ECF812C2B3')
  end

  def self.file_list
    self.find('BFC9D190-BCD6-411A-B9F9-3160D3F68819')
  end

  def self.refs_list
    self.find('E63E748B-DDDB-43C3-B0B4-7AE867B9483C')
  end

  def self.process
    self.find('AE82DD57-348C-4407-A50A-9F2C7D694DA8')
  end

  protected

  def assign_required_attributes
    self.Timestamp ||= "\x00"
  end

end