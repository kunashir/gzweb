require 'spec_helper'

describe TasksInfo do

  context 'by default' do
    subject { TasksInfo.new }

    its(:performing) { should == 0 }
    its(:performing_new) { should == 0 }
    its(:to_accept) { should == 0}
    its(:to_accept_new) { should == 0 }
    its(:long_tasks) { should == 0 }
    its(:long_tasks_new) { should == 0 }
    its(:to_approve) { should == 0 }
    its(:to_approve_new) { should == 0 }
    its(:to_sign) { should == 0 }
    its(:to_sign_new) { should == 0 }
    its(:informational) { should == 0 }
    its(:informational_new) { should == 0 }
    its(:issued) { should == 0 }
    its(:issued_new) { should == 0 }
    its(:long_issued) { should == 0 }
    its(:long_issued_new) { should == 0 }
    its(:delegated) { should == 0 }
    its(:delegated_new) { should == 0 }
    its(:overdue) { should == 0 }
    its(:upcoming) { should == 0 }
    its(:controlled) { should == 0 }
  end

  it 'retrieving for employee returns some data' do
    TasksInfo.get(FactoryGirl.create :user).should_not be_nil
  end

  context 'dummy data' do
    subject { FactoryGirl.create :tasks_info }

    its(:performing) { should == 10 }
    its(:performing_new) { should == 2 }
    its(:to_accept) { should == 1 }
    its(:to_accept_new) { should == 0 }
    its(:long_tasks) { should == 4 }
    its(:long_tasks_new) { should == 1 }
    its(:to_approve) { should == 5 }
    its(:to_approve_new) { should == 0 }
    its(:to_sign) { should == 0 }
    its(:to_sign_new) { should == 0 }
    its(:informational) { should == 8 }
    its(:informational_new) { should == 6 }
    its(:issued) { should == 5 }
    its(:issued_new) { should == 1 }
    its(:long_issued) { should == 2 }
    its(:long_issued_new) { should == 0 }
    its(:delegated) { should == 45 }
    its(:delegated_new) { should == 17 }
    its(:overdue) { should == 10 }
    its(:upcoming) { should == 6 }
    its(:controlled) { should == 3 }
  end
end