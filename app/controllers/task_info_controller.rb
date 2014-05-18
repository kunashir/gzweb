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
      format.json { render json: { task_list: format_task_list(@task_list) } }
    end
  end

  protected

  def format_task_list(task_list)
    task_list.map { |x| format_task(x) }
  end

  def format_task(task)
    data = task.attributes
    data[:files] = task.task_files
    data
  end

end