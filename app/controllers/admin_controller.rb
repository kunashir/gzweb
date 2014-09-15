class AdminController < ActionController::Base
  layout 'admin'

  before_action :authenticate_admin!

  def main
    @users = User.all
  end

  def user_details
    user = User.find_by_id(params[:id].to_i)
    render json: { user: user }
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
end