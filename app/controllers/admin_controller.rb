class AdminController < ActionController::Base
  layout 'admin'

  before_action :authenticate_admin!

  def main
    @users = User.all
  end

  def user_details
    user = User.find_by_id(params[:user_id].to_i)
    task_count = 0
    quick_performers = []
    controller_name = ''
    unless user.nil?
      task_count = TaskInfo.where(user: user).count
      quick_performers = user.quick_performers.map { |x| { employee_id: x.employee_id, employee_name: x.employee.try(:display_name), order: x.order } }
      controller_name = user.controller.try(:display_name)
    end
    render json: { user: user, controller_name: controller_name, task_count: task_count, quick_performers: quick_performers }
  end

  def add_user
    employee = TakeOffice::Employee.where(RowID: params[:employee_id]).first
    unless employee.nil?
      User.create!(employee_id: employee, account_name: SecureRandom.uuid, password: params[:password])
    end
    redirect_to admin_path
  end

  def remove_user
    user = User.find_by_id(params[:user_id])
    unless user.nil?
      user.destroy
    end
    redirect_to admin_path
  end

  def save_quick_performers
    user = User.find_by_id(params[:user_id].to_i)
    unless user.nil?
      employees = params[:quick_performers].map { |x| TakeOffice::Employee.where(RowID: x).first }.select { |x| !x.nil? }
      user.quick_performers.destroy_all
      index = 0
      employees.each do |employee| 
       user.quick_performers << QuickPerformer.create!(employee: employee, order: index)
       index = index + 1
      end      
    end
    head :no_content
  end

  def save_controller
    user = User.find_by_id(params[:user_id].to_i)
    user.controller_id = params[:controller_id]
    user.save!
    head :no_content
  end

  def set_user_password
    user = User.find_by_id(params[:user_id].to_i)
    user.password = params[:password]
    user.save!
    head :no_content
  end

  def set_user_refresh_period
    user = User.find_by_id(params[:user_id].to_i)
    if params[:refresh_period].blank?
      user.refresh_minutes = nil
    else
      user.refresh_minutes = params[:refresh_period]
    end
    user.save!
    head :no_content
  end

  def refresh_user
    user = User.find_by_id(params[:user_id].to_i)
    TasksInfo.sync(user)
    render json: { task_count: TaskInfo.where(user: user).count }
  end

end