require 'spec_helper'

describe CardType do

  context 'common card types' do
    subject { CardType }
    its(:assignment) { should_not be_nil }
    its(:assignment) { should be_instance_of(CardType) }
    its(:ref_staff)  { should_not be_nil }
    its(:ref_staff)  { should be_instance_of(CardType) }
  end

end