#encoding: UTF-8

class TaskInfoController < ApplicationController
  
  def show
    @task_info = TasksInfo.get(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { task_info: @task_info } }
    end
  end

  def tasks
    @task_list = TaskList.get(current_user, params[:kind].to_sym).sort_by { |x| x.date }.reverse
    if (current_user.last_refresh_date.nil?)
      autorefresh_delay = 90
    else
      autorefresh_delay = (current_user.last_refresh_date + (current_user.refresh_minutes || 15).minutes + 30.seconds - DateTime.now).to_i
      if (autorefresh_delay < 30)
        autorefresh_delay = 30
      end
    end
    tasks_info = TasksInfo.get(current_user)
    respond_to do |format|
      format.html # tasks.html.erb
      format.json { render json: { task_list: format_task_list(@task_list), info: tasks_info, autorefresh_delay: autorefresh_delay } }
    end
  end

  def perform
    begin
      @task = TaskInfo.find_by_id(params[:id])
      options = {}
      unless params[:comments].nil?
        options[:comments] = params[:comments]
      end
      unless params[:files].nil?
        options[:files] = params[:files]
      end
      result = @task.perform(params[:task_action], current_user, options)
    rescue Exception => ex
      error = ex.message
      error = "Внутреняя ошибка приложения" if error.blank?
      logger.error ex.message
      ex.backtrace.each { |line| logger.error line }
    end
    if error.nil? || error.blank?
      render json: { result: result }, status: 200
    else
      render json: { error: error }, status: 422
    end
  end

  def refresh
    TasksInfo.sync(current_user)
    head :no_content
  end

  def history
    begin
      @task = TaskInfo.find(params[:id])
      render json: { history: @task.history }, status: 200
    rescue
      render json: { history: { cycles: [] } }, status: 200
    end
  end

  def assignment_tree
    @task = TaskInfo.find(params[:id])
    respond_to do |format|
      format.html # tasks.html.erb
      format.json {
        begin
          render json: { tree: @task.assignment_tree }, status: 200
        rescue Exception => ex
          render json: { tree: {}, error: ex.message, backtrace: ex.backtrace }, status: 200
        end
      }
    end    
  end

  protected

  def format_task_list(task_list)
    task_list.map { |x| format_task(x) }
  end

  def format_task(task)
    data = task.attributes
    data[:files] = task.task_files
    data["deadline_time"] = data["deadline"].strftime("%H:%M") unless data["deadline"].nil?
    data["deadline_date"] = data["deadline"].strftime("%d.%m.%Y") unless data["deadline"].nil?
    data["deadline"] = data["deadline"].strftime("%d.%m.%Y %H:%M") unless data["deadline"].nil?
    data["date_time"] = data["date"].strftime("%H:%M") unless data["date"].nil?
    data["date_date"] = data["date"].strftime("%d.%m.%Y") unless data["date"].nil?
    data["order_date"] = data["date"].strftime("%Y.%m.%d %H:%M:%S") unless data["date"].nil?
    data["date"] = data["date"].strftime("%d.%m.%Y %H:%M") unless data["date"].nil?
    data[:actions] = translate_actions(task.actions)
    unless data["co_performers"].nil?
      data["co_performers"] = data["co_performers"].split("||").map { |x| 
          { name: x.split("@@")[0], position: x.split("@@")[1] } }
    else
      data["co_performers"] = []
    end
    data
  end

  def translate_actions(actions) 
    return nil if actions.nil?
    return actions.map { |x| { action: x[:action], text: I18n.t(x[:text]), comments_required: x[:comments_required], actions: translate_actions(x[:actions]) } }
  end

end
