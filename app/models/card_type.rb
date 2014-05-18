class CardType < ActiveRecord::Base
  self.table_name = 'dvsys_carddefs'
  self.primary_key = 'CardTypeID'

  belongs_to :sid, class_name: :SecurityDescriptor, primary_key: 'ID', foreign_key: 'SDID'

  def self.assignment
    self.find('FFF11133-DFC4-4CD6-A2D4-BD242E2A4670')
  end

  def self.ref_staff
    self.find('6710B92A-E148-4363-8A6F-1AA0EB18936C')
  end

end