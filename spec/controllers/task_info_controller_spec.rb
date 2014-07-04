#encoding: UTF-8

require 'spec_helper'

describe TaskInfoController do

  let(:dummy_tasks_info) { FactoryGirl.create :tasks_info }

  context 'Requesting overall task information' do
    set_user_logged_in

    it 'should request task information from model for current user' do
      TasksInfo.should_receive(:get).
        with(subject.current_user).
        and_return(dummy_tasks_info)
      get :show, format: :json
    end

    it 'should convert task information from model to json' do
      TasksInfo.stub(:get).
        with(subject.current_user).
        and_return(dummy_tasks_info)
      get :show, format: :json
      response.status.should == 200
      response.body.should == 
      { 
        task_info:
        { 
          id: nil,
          performing: 10,
          performing_new: 2,
          to_accept: 1,
          to_accept_new: 0,
          long_tasks: 4,
          long_tasks_new: 1,
          to_approve: 5,
          to_approve_new: 0,
          to_sign: 0,
          to_sign_new: 0,
          informational: 8,
          informational_new: 6,
          issued: 5,
          issued_new: 1,
          long_issued: 2,
          long_issued_new: 0,
          delegated: 45,
          delegated_new: 17,
          overdue: 10,
          upcoming: 6,
          controlled: 3,
          user_id: nil
        } 
      }.to_json
    end
  end

  let(:task_list_dummy) { FactoryGirl.create :task_list_dummy }

  context "Requesting details on dummy performing" do
    set_user_logged_in

    it "should request information from model for current user" do
      TaskList.should_receive(:get).
        with(subject.current_user, :performing).
        and_return(task_list_dummy)
      get :tasks, format: :json, kind: :performing
      response.status.should == 200
    end

    it "should format list received from model as json" do
      TaskList.stub(:get).
        with(subject.current_user, :performing).
        and_return(task_list_dummy)

      get :tasks, format: :json, kind: :performing
      response.status.should == 200
      # order of tasks reveresed due to sort by date desc
      response.body.should == 
      { 
        task_list:
        [ 
          { id: 2,
            task_id: "3c8bf8fc-c412-472b-b642-f590c8022902",
            author_id: "add2cdd1-9f00-47d1-9bc5-035398fcc5a8",
            author_name: "Мирошин К.К.",
            author_position: "Манагер",
            controler_id: nil,
            controler_name: nil,
            controler_position: nil,
            delegated_to: "Богданов Д.А.",
            subject: "Поручение от 10.02.2013",
            content: "Проверить работу web-решения для работы с поручениями в ГОЗНАК",
            deadline: "12.05.2014 18:00",
            date: "15.04.2013 00:00",
            task_state: nil,
            state: nil,
            task_type: nil,
            parent_document_id: "bcbce55c-c9df-4ba5-8d75-c19b558b66e6",
            parent_document: "6/2014",
            folder: nil,
            user_id: nil,
            files: [],
            deadline_time: "18:00",
            deadline_date: "12.05.2014",
            date_time: "00:00",
            date_date: "15.04.2013"
          },
          { id: 1,
            task_id: "261a8630-0924-4e68-9170-f5b6def97cfe",
            author_id: "577dadd4-27ba-4adb-8ea5-33e5d9cb1e43",
            author_name: "Сидоренков А.Ю.",
            author_position: "Генерал",
            controler_id: "add2cdd1-9f00-47d1-9bc5-035398fcc5a8",
            controler_name: "Мирошин К.К.",
            controler_position: "Манагер",
            delegated_to: nil,
            subject: "Исходящий документ подписан",
            content: "Распечатайте пожалуйста и отсканируйте копию исходящего документа.",
            deadline: nil,
            date: "13.04.2013 00:00",
            task_state: nil,
            state: nil,
            task_type: nil,
            parent_document_id: "2ef64727-818b-44d5-9e2f-e57fe6361c22",
            parent_document: "2/2014",
            folder: nil,
            user_id: nil,
            files: [],
            date_time: "00:00",
            date_date: "13.04.2013"
          }
        ]
      }.to_json
    end
  end
end