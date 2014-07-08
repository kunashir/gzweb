#encoding: UTF-8

require 'spec_helper.rb'

describe 'Seeds for test database' do

  it "root departments should contain 'ООО \"АйДок\"' и 'ООО \"Гознак\"'" do
    TakeOffice::Department.root.map { |x| x.Name }.should =~ ['ООО "АйДок"', 'ООО "Гознак"']
  end

  it "ООО \"АйДок\" should contain 'Отдел продаж', 'Отдел поддержки'" do
    idoc = TakeOffice::Department.root.where(Name: 'ООО "АйДок"').first
    idoc.children.map { |x| x.Name }.should =~ ['Отдел продаж', 'Отдел поддержки']
  end

  it "ООО \"Гознак\" should not contain any subdepartments" do
    idoc = TakeOffice::Department.root.where(Name: 'ООО "Гознак"').first
    idoc.children.should =~ []
  end

  it "'ООО \"АйДок\"' should contain 'Сидоренков А.Ю.'" do
    dep = TakeOffice::Department.where(Name: 'ООО "АйДок"').first
    dep.employees.map { |x| x.DisplayString }.should =~ ['Сидоренков А.Ю.']
    dep.employees.map { |x| x.NotAvailable }.should =~ [ false ]
  end
  
  it "'Отдел продаж' should contain 'Мирошин К.Г.' and 'Захаров Е.'" do
    dep = TakeOffice::Department.where(Name: 'Отдел продаж').first
    dep.employees.map { |x| x.DisplayString }.should =~ ['Мирошин К.Г.', 'Захаров Е.']
    dep.employees.where(DisplayString: 'Мирошин К.Г.').first.NotAvailable.should == false
    dep.employees.where(DisplayString: 'Захаров Е.').first.NotAvailable.should == true
  end

  it "'Отдел поддержки' should contain 'Мосолов К.В.' and 'Иванов И.И.'" do
    dep = TakeOffice::Department.where(Name: 'Отдел поддержки').first
    dep.employees.map { |x| x.DisplayString }.should =~ ['Мосолов К.В.', 'Иванов И.И.']
    dep.employees.map { |x| x.NotAvailable }.should =~ [ false, false ]
  end

end