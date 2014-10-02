#encoding: UTF-8

require 'spec_helper'

describe User do
  context 'by default' do
    subject { User.new }

    its(:id) { should be_nil }
    its(:first_name) { should be_nil }
    its(:last_name) { should be_nil }
    its(:display_name) { should be_nil }
  end

  its 'to_s should return display_name' do
    u = User.new
    u.should_receive(:display_name).and_return("-тестовое-значение-")
    u.to_s.should == "-тестовое-значение-"
  end

  it 'should return employee' do
    u = User.first

    TakeOffice::Employee.should_receive(:where).
      with({RowID: u.employee_id}).
      and_return([234234234])

    u.employee.should == 234234234
  end

  it 'should assign employee' do
    u = User.new

    employee = double('TakeOffice::Employee')
    employee.should_receive(:id).and_return(12512)

    u.employee = employee
    u.employee_id.should == 12512
  end
end
