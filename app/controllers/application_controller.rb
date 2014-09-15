require 'take_office/employee'

class ApplicationController < ActionController::Base

  def current_user
    super || User.first
  end

  def current_employee
    return @current_employee unless @current_employee.nil?
    return nil unless current_user.respond_to? 'employee_id'
    @current_employee = TakeOffice::Employee.find(current_user.employee_id)
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.to_s == "admin"
      admin_path
    else
      root_path
    end
  end

end
