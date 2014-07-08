require 'spec_helper'

describe CardType do

  context 'common card types' do
    subject { CardType }
    its(:assignment) { should_not be_nil }
    its(:assignment) { should be_instance_of(CardType) }
    its(:ref_staff)  { should_not be_nil }
    its(:ref_staff)  { should be_instance_of(CardType) }
    
    its(:workflow_task_id) { should == "F7E2090A-EEC3-4B51-B1BB-567D4A0117D6" }
    its(:workflow_task) { should_not be_nil }
    its(:workflow_task) { should be_instance_of(CardType) }
    it 'should have correct worklow task type identifier' do
      subject.workflow_task.id.should == "F7E2090A-EEC3-4B51-B1BB-567D4A0117D6"
    end
  end

end