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
    unless user.nil?
      task_count = TaskInfo.where(user: user).count
      quick_performers = user.quick_performers.map { |x| { employee_id: x.employee_id, employee_name: x.employee.try(:display_name), order: x.order } }
    end
    render json: { user: user, task_count: task_count, quick_performers: quick_performers }
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
    head 200
  end

  def set_user_password
    user = User.find_by_id(params[:user_id].to_i)
    user.password = params[:password]
    user.save!
    head 200
  end

  def refresh_user
    user = User.find_by_id(params[:user_id].to_i)
    TasksInfo.sync(user)
    render json: { task_count: TaskInfo.where(user: user).count }
  end

end