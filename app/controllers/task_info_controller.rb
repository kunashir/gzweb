class TaskInfoController < ApplicationController
  
  def show
    @task_info = TasksInfo.get(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { task_info: @task_info } }
    end
  end

  def tasks
    @task_list = TaskList.get(current_user, params[:kind].to_sym).sort_by { |x| x.date }
    respond_to do |format|
      format.html # tasks.html.erb
      format.json { render json: { task_list: @task_list }}
    end
  end

end