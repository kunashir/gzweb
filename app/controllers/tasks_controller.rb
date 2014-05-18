class TasksController < ApplicationController

  def new
    @task = Task.new.init(current_user)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: { task: @task } }
    end
  end

  def create
  end

  def show
  end
end