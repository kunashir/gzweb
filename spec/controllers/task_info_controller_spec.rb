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
          controlled: 3
        } 
      }.to_json
    end
  end

  let(:task_list_dummy) { FactoryGirl.create :task_list_dummy }

  [:performing, :to_approve, :long_tasks,
   :to_accept, :to_sign, :informational,
   :issued, :long_issued, :delegated].each do |kind|
    context "Requesting details on #{kind}" do
      set_user_logged_in

      it "should request information from model for '#{kind}' of current user" do
        TaskList.should_receive(:get).
          with(subject.current_user, kind).
          and_return(task_list_dummy)
        get :tasks, format: :json, kind: kind
        response.status.should == 200
      end

      it "should format list received from model for '#{kind}' as json" do
        TaskList.stub(:get).
          with(subject.current_user, kind).
          and_return(task_list_dummy)
        get :tasks, format: :json, kind: kind
        response.status.should == 200
        response.body.should == 
        { 
          task_list:
          [ 
            { id: "C10B0DEC-1234-5678-ABCD-000000000001",
              author: "Сидоренков А.Ю.",
              date: "2013-04-13T00:00:00+00:00",
              doc_number: "2/2014",
              subject: "Исходящий документ подписан",
              content: "Распечатайте пожалуйста и отсканируйте копию исходящего документа." },
            { id: "C10B0DEC-1234-5678-ABCD-000000000002",
              author: "Мирошин К.К.",
              date: "2013-04-15T00:00:00+00:00",
              doc_number: "6/2014",
              subject: "Поручение от 10.02.2013",
              content: "Проверить работу web-решения для работы с поручениями в ГОЗНАК",
              deadline: "2014-05-12T18:00:00+00:00",
              delegated_to: "Богданов Д.А." }
          ]
        }.to_json
      end
    end
  end
end