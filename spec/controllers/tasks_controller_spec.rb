require 'spec_helper'

describe TasksController do
  set_user_logged_in

  context 'creation of new task' do
    it 'should respond to new method' do
      get :new
      response.status.should == 200
    end

    it 'should respond to create method' do
      post :create
      response.status.should == 422
    end

    it 'should request model to init new task fields' do
      task = Task.new
      Task.should_receive(:new).
        and_return(task)
      task.should_receive(:init).
        with(subject.current_user).
        and_return(task)
      get :new
    end

    context 'creating a new task through json' do
      it 'should return new task data on new method' do
        dummy_task = Task.new
        Task.should_receive(:new).
          and_return(dummy_task)
        dummy_task.should_receive(:init).
          with(subject.current_user).
          and_return(dummy_task)
        get :new, format: :json
        response.status.should == 200
        response.body.should == {
          task: dummy_task
        }.to_json
      end
    end
  end

  context 'viewing existing task' do
    it 'should respond to show method' do
      get :show, id: 1
      response.status.should == 404
    end
  end
end