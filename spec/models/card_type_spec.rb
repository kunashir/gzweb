require 'spec_helper'

describe CardType do

  context 'common card types' do
    subject { CardType }
    its(:assignment) { should_not be_nil }
    its(:assignment) { should be_instance_of(CardType) }

    its(:ref_staff)  { should_not be_nil }
    its(:ref_staff)  { should be_instance_of(CardType) }

    its(:file_list_id) { should == "BFC9D190-BCD6-411A-B9F9-3160D3F68819" }
    its(:file_list) { should_not be_nil }
    its(:file_list) { should be_instance_of(CardType) }
    it 'should have correct file list identifier' do
      subject.file_list.id.should == "BFC9D190-BCD6-411A-B9F9-3160D3F68819"
    end

    its(:workflow_task_id) { should == "F7E2090A-EEC3-4B51-B1BB-567D4A0117D6" }
    its(:workflow_task) { should_not be_nil }
    its(:workflow_task) { should be_instance_of(CardType) }
    it 'should have correct worklow task type identifier' do
      subject.workflow_task.id.should == "F7E2090A-EEC3-4B51-B1BB-567D4A0117D6"
    end

    its(:memorandum_type_id) { should == "816AE98F-0E9C-4734-B368-642A34948527" }
  end

end