require 'spec_helper'

describe Card do
  it 'can be created in database' do
    card = Card.new(card_type: CardType.first)
    card.save.should == true
  end

  it 'is invalid if card type not set' do
    card = Card.new
    card.save.should == false
    card.should_not be_valid
  end

  it 'different cards have different identifiers' do
    card = Card.new(card_type: CardType.first)
    card.save

    other = Card.new(card_type: CardType.first)
    other.save

    other.id.should_not == card.id
  end

  context 'default' do
    subject { Card.new }

    its(:id) { should be_nil }
    its(:card_type) { should be_nil }
    its(:timestamp) { should be_nil }
    its(:description) { should == "" }
    its(:sid) { should be_nil }
    its(:is_deleted) { should == false }
    it { should_not be_deleted }
    its(:is_template) { should == false }
    it { should_not be_template }
    its(:topic) { should be_nil }
    its(:topic_index) { should == 0 }
    its(:parent_id) { should == "00000000-0000-0000-0000-000000000000" }
    its(:order) { should == 0 }
    its(:archive_state) { should == 0 }
    its(:change_date) { should be_nil }
    its(:create_date) { should be_nil }
    its(:timestamp) { should be_nil }
  end

  it 'if sid is not specified for the new card, it is taken from card type' do
    card_type = CardType.first
    card_type.sid.should_not be_nil

    card = Card.new(card_type: card_type)
    card.save!

    card.sid.should == card_type.sid
  end

  it 'after save timestamp is assigned to non-nil value' do
    card_type = CardType.first

    card = Card.new(card_type: card_type)
    card.save!

    card.timestamp.should_not be_nil
  end

  context 'saving card creates record in dvsys_instances_date' do
    let!(:card) { Card.create(card_type: CardType.first) }
    subject { CardDate.where(InstanceID: card.InstanceID).first }

    it { should_not be_nil }
    its(:InstanceID) { should match(%r{#{card.InstanceID}}i) }
    its(:change_date) { should == subject.create_date }
  end

  context 'card should have create_date and change_date delegated' do
    subject { Card.create(card_type: CardType.first) }
    
    its(:create_date) { should == subject.card_date.create_date }
    its(:change_date) { should == subject.card_date.change_date }
  end

  context 'saving card changes change_date' do
    subject do
      card = Card.create(card_type: CardType.first) 
      card.description = "A very nice card"
      card.save!
      card
    end

    its(:change_date) { should_not == subject.create_date }
  end
end