#encoding: UTF-8

require 'spec_helper.rb'

describe TakeOffice::Employee do

  context 'by default' do
    subject { TakeOffice::Employee.new }

    its(:RowID) { should be_nil }
    its(:ParentRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:ParentTreeRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:InstanceID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:sid) { should be_nil }
    its(:parent) { should be_nil }
    its(:DisplayString) { should == "" }
    its(:NotAvailable) { should == false }
  end

  context 'after save' do
    let(:department) { TakeOffice::Department.first }
    subject { TakeOffice::Employee.create!(DisplayString: 'Сидоренков А.Ю.', parent: department) }

    its(:RowID) { should_not be_nil }
    its(:ParentRowID) { should == department.RowID }
    its(:ParentTreeRowID) { should == "00000000-0000-0000-0000-000000000000" }
    its(:InstanceID) { should == TakeOffice::RefStaff.InstanceID }
    its(:sid) { should be_nil }
    its(:DisplayString) { should == 'Сидоренков А.Ю.' }
    its(:NotAvailable) { should == false }
  end

  context 'searching' do
    it 'should find all database employees via "_" clause with NotAvailable = false' do
      search_result = TakeOffice::Employee.search('_')
      search_result.map { |x| x.RowID.downcase }.should =~ 
        TakeOffice::Employee.where(NotAvailable: false).map { |x| x.RowID.downcase }
    end

    it 'searching for "Ми" should return the only result "Мирошин К.Г."' do
      search_result = TakeOffice::Employee.search('Ми')
      search_result.map { |x| x.RowID.downcase }.should =~ 
        TakeOffice::Employee.where(DisplayString: 'Мирошин К.Г.').map { |x| x.RowID.downcase }
    end

    it 'searching for "М" should return "Мирошин К.Г." and "Мосолов К.В."' do
      search_result = TakeOffice::Employee.search('М')
      search_result.map { |x| x.RowID.downcase }.should =~ 
        [ TakeOffice::Employee.where(DisplayString: 'Мирошин К.Г.').map { |x| x.RowID.downcase }.first,
          TakeOffice::Employee.where(DisplayString: 'Мосолов К.В.').map { |x| x.RowID.downcase }.first]
    end

    it 'searcing for "За" should be empty, as long as "Захаров Е." is not available' do
      search_result = TakeOffice::Employee.search('За')
      search_result.should be_empty
    end
  end
end