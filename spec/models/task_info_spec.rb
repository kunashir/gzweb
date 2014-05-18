#encoding: UTF-8
require 'spec_helper'

describe TaskInfo do

	context 'by default' do
		subject { TaskInfo.new }

    its(:id) { should == "00000000-0000-0000-0000-000000000000" }
    its(:date) { should be_nil }
    its(:author) { should be_nil }
    its(:doc_number) { should be_nil }
    its(:subject) { should be_nil }
    its(:content) { should be_nil }
    its(:deadline) { should be_nil }
    its(:delegated_to) { should be_nil }

	end

  context 'dummy1' do
    subject { FactoryGirl.create :task_info_dummy1 }

    its(:id) { should == "C10B0DEC-1234-5678-ABCD-000000000001" }
    its(:date) { should == Time.new(2013, 04, 13, 0, 0, 0, 0) }
    its(:author) { should == "Сидоренков А.Ю." }
    its(:doc_number) { should == "2/2014" }
    its(:subject) { should == "Исходящий документ подписан" }
    its(:content) { should == "Распечатайте пожалуйста и отсканируйте копию исходящего документа." }
    its(:deadline) { should be_nil }
    its(:delegated_to) { should be_nil }
  end

  context 'dummy2' do
    subject { FactoryGirl.create :task_info_dummy2 }

    its(:id) { should == "C10B0DEC-1234-5678-ABCD-000000000002" }
    its(:date) { should == Time.new(2013, 04, 15, 0, 0, 0, 0) }
    its(:author) { should == "Мирошин К.К." }
    its(:doc_number) { should == "6/2014" }
    its(:subject) { should == "Поручение от 10.02.2013" }
    its(:content) { should == "Проверить работу web-решения для работы с поручениями в ГОЗНАК" }
    its(:deadline) { should == Time.new(2014, 05, 12, 18, 0, 0, 0) }
    its(:delegated_to) { should == "Богданов Д.А." }
  
  end

  it 'random should generate randomized task instances' do
    ids = []
    doc_numbers = []
    authors = []
    contents = []
    subjects = []
    dates = []
    deadlines = []
    delegated_to = []

    (0..100).each do
        task_info = TaskInfo.random

        task_info.id.should =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
        ids.should_not include(task_info.id)
        ids << task_info.id        

        task_info.doc_number.should =~ /^[0-9]{1,3}\/201[34]$/i
        doc_numbers << task_info.doc_number unless doc_numbers.include? task_info.doc_number

        RandomHelper.persons.should include(task_info.author)
        authors << task_info.author unless authors.include? task_info.author

        RandomHelper.contents.should include(task_info.content)
        contents << task_info.content unless contents.include? task_info.content

        RandomHelper.subjects.should include(task_info.subject)
        subjects << task_info.content unless subjects.include? task_info.subject

        task_info.date.should > Time.now - 2.years
        task_info.date.should < Time.now
        dates << task_info.date

        unless task_info.deadline.nil?
            task_info.deadline.should > Time.now - 1.week
            task_info.deadline.should < Time.now + 1.month
        end
        deadlines << task_info.deadline

        unless task_info.delegated_to.nil?
            RandomHelper.persons.should include(task_info.delegated_to)
        end
        delegated_to << task_info.delegated_to unless delegated_to.include? task_info.delegated_to
    end

    doc_numbers.length.should > 10
    authors.length.should >= RandomHelper.persons.count / 2
    contents.length.should >= RandomHelper.contents.count / 2
    subjects.length.should >= RandomHelper.subjects.count / 2

    dates.select { |x| x < Time.now - 1.years }.should_not be_empty
    dates.select { |x| x > Time.now - 1.years && x < Time.now - 1.month }.should_not be_empty
    dates.select { |x| x > Time.now - 1.month && x < Time.now - 1.week }.should_not be_empty
    dates.select { |x| x > Time.now - 1.week }.should_not be_empty

    deadlines.select { |x| x.nil? }.should_not be_empty
    deadlines.select { |x| !x.nil? && x < Time.now }.should_not be_empty
    deadlines.select { |x| !x.nil? && Time.now < x && x < Time.now + 1.day }.should_not be_empty
    deadlines.select { |x| !x.nil? && Time.now + 1.day < x && x < Time.now + 3.days }.should_not be_empty
    deadlines.select { |x| !x.nil? && x > Time.now + 3.days }.should_not be_empty

    delegated_to.select { |x| x.nil? }.should_not be_empty
    delegated_to.length.should >= RandomHelper.persons.count / 2 + 1
  end
end