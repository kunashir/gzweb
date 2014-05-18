#encoding: UTF-8

require 'spec_helper.rb'

describe TakeOffice::Department do

  context 'by default' do
    subject { TakeOffice::Department.new }

    its(:RowID) { should be_nil }
    its(:ParentRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:ParentTreeRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:InstanceID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:sid) { should be_nil }
  end

  context 'after save' do
    subject { TakeOffice::Department.create!(Name: 'Основной отдел') }

    its(:RowID) { should_not be_nil }
    its(:ParentRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:ParentTreeRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:InstanceID) { should == TakeOffice::RefStaff.InstanceID }
    its(:sid) { should be_nil }
    its(:Name) { should == 'Основной отдел' }

    it 'should be present in root departments' do
      TakeOffice::Department.root.where(RowID: subject.RowID).length.should == 1
    end
  end

end