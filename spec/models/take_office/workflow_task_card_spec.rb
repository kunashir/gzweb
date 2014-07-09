#encoding: UTF-8
require 'spec_helper'

module TakeOffice
  describe WorkflowTaskCard do

    context 'Marking task as completed' do
      let(:completed_by) { Employee.first }
      let(:db_now) { (Time.now + Time.zone_offset(Time.now.zone)).in_time_zone }

      subject {
        task = WorkflowTaskCard.new
        task.main_info.name = 'Поручение обычное'
        task.save!

        task.mark_completed(1, completed_by, {})
        task = WorkflowTaskCard.find(task.id)
      }

      it 'state should become completed' do
        subject.performing.state.should == :completed
        subject.performing.TaskState.should == 5
      end

      it 'description should change to '', Завершено''' do
        subject.description.should == 'Поручение обычное, Завершено'
      end

      it 'given user should become CompletedEmployee in Performing' do
        subject.performing.completed_employee.should == completed_by
      end

      it 'end date should be set to current time plus zone shift' do
        (subject.performing.actual_end_date - db_now).should < 5
      end

      it 'should have a log item for completion' do
        subject.log.length.should == 1
        subject.log.first.action.should == :task_finished
        subject.log.first.action_by.should == completed_by
        (subject.log.first.action_date - db_now).should < 5
      end

      it 'should not have comments' do
        subject.comments.should be_empty
      end
    end

    it 'should add completion comments upon completion' do
      completed_by = Employee.first
      db_now = (Time.now + Time.zone_offset(Time.now.zone)).in_time_zone

      task = WorkflowTaskCard.new
      task.main_info.name = 'Поручение обычное'
      task.save!

      task.mark_completed(1, completed_by, { comments: 'Всякий разный текст завершения' })
      task = WorkflowTaskCard.find(task.id)

      task.comments.length.should == 1
      task.comments[0].should be_report
      task.comments[0].text.should == 'Всякий разный текст завершения' 
      task.comments[0].created_by.should == completed_by
      (task.comments[0].creation_date - db_now).should < 5

      task.log.length.should == 2
      task.log[0].action.should == :add_comment
      task.log[0].action_by.should == completed_by
      (task.log[0].action_date - db_now).should < 5

      task.log[1].action.should == :task_finished
      task.log[1].action_by.should == completed_by
      (task.log[1].action_date - db_now).should < 5
    end

    it 'should set completion variant upon completion' do
      completed_by = Employee.first
      db_now = (Time.now + Time.zone_offset(Time.now.zone)).in_time_zone

      task = WorkflowTaskCard.new
      task.main_info.name = 'Поручение обычное'
      task.add_completion_param(name: 'Вариант завершения:')
      task.save!

      task.mark_completed(2, completed_by, { comments: 'Всякий разный текст завершения' })
      task = WorkflowTaskCard.find(task.id)

      task.completion_params.length.should == 1
      task.completion_params[0].name.should == "Вариант завершения:"
      task.completion_params[0].value.to_i.should == 2
    end    

    it 'should store files in performer file list upon completion' do
      completed_by = Employee.first
      db_now = (Time.now + Time.zone_offset(Time.now.zone)).in_time_zone

      task = WorkflowTaskCard.new
      task.main_info.name = 'Поручение обычное'
      task.save!

      task.mark_completed(1, completed_by, { files: ['265d744b-40ad-4f38-aea2-159fc500f233', 'bb778cd4-cc7e-4e7d-acff-855c98a1e30e'] })
      task = WorkflowTaskCard.find(task.id)

      task.main_info.performer_files.should_not be_nil
      task.main_info.performer_files.should be_instance_of(FileListCard)
      task.main_info.performer_files.references.length.should == 2
      task.main_info.performer_files.references[0].file_id.should == '265d744b-40ad-4f38-aea2-159fc500f233'
      task.main_info.performer_files.references[1].file_id.should == 'bb778cd4-cc7e-4e7d-acff-855c98a1e30e'
    end    
  end
end
