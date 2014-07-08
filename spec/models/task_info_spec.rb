#encoding: UTF-8
require 'spec_helper'

describe TaskInfo do

    context 'by default' do
        subject { TaskInfo.new }

        its(:task_id) { should == "00000000-0000-0000-0000-000000000000" }
        its(:date) { should be_nil }
        its(:author_id) { should be_nil }
        its(:author_name) { should be_nil }
        its(:parent_document_id) { should be_nil }
        its(:parent_document) { should be_nil }
        its(:subject) { should be_nil }
        its(:content) { should be_nil }
        its(:deadline) { should be_nil }
        its(:delegated_to) { should be_nil }
    end

    it 'random should generate randomized task instances' do
        task_ids = []
        parent_documents = []
        authors = []
        contents = []
        subjects = []
        dates = []
        deadlines = []
        delegated_to = []

        (0..100).each do
            task_info = TaskInfo.random

            task_info.task_id.should =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
            task_ids.should_not include(task_info.task_id)
            task_ids << task_info.task_id        

            task_info.parent_document.should =~ /^[0-9]{1,3}\/201[34]$/i
            parent_documents << task_info.parent_document unless parent_documents.include? task_info.parent_document

            RandomHelper.persons.should include(task_info.author_name)
            authors << task_info.author_name unless authors.include? task_info.author_name

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

        parent_documents.length.should > 10
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

    context 'IncDoc reviewal task' do
        it 'Should return single action with non-required comments' do
            task = FactoryGirl.create(:task_info_dummy1)
            task.kind = 'incdoc_reviewal'

            task.actions.should =~ [ { action: :complete, text: 'task.incdoc_reviewal.complete', comments_required: false }]
        end

        it 'Should return :folder_remove after ''complete'' action is performed' do
            task = FactoryGirl.create(:task_info_dummy1)
            task.kind = 'incdoc_reviewal'

            card = double('TaskCard')
            TakeOffice::WorkflowTaskCard.stub(:find).with(task.task_id).and_return(card)
            card.stub(:mark_completed)

            task.perform('complete', User.first, {}).should == :folder_remove
        end

        it 'Should be removed from database after ''complete'' action is performed' do
            task = FactoryGirl.create(:task_info_dummy1)
            task.kind = 'incdoc_reviewal'

            card = double('TaskCard')
            TakeOffice::WorkflowTaskCard.stub(:find).with(task.task_id).and_return(card)
            card.stub(:mark_completed)

            task.should_receive(:destroy).and_return(true)
            
            task.perform('complete', User.first, {})
        end

        it 'should request task to be mark_completed in DV card when ''complete'' action is performed' do
            task = FactoryGirl.create(:task_info_dummy1)
            task.kind = :incdoc_reviewal

            card = double('TaskCard')
            TakeOffice::WorkflowTaskCard.should_receive(:find).with(task.task_id).and_return(card)
            card.should_receive(:mark_completed).
                with(User.first.employee, { comments: 'hello', blabla: 'ttrtrt '})

            # main_info = double('TaskCardMainInfo')
            # TaskCard.should_receive(:find).with(task.task_id).and_return(card)
            # card.should_receive(:main_info).and_return(main_info)
            # main_info.should_receive('state=').with(5)
            # card.should_receive(:save!)

            task.perform('complete', User.first, { comments: 'hello', blabla: 'ttrtrt '})
        end
    end
end