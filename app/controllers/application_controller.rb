require 'take_office/employee'

class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.first
  end

  def current_employee
    return @current_employee unless @current_employee.nil?
    return nil unless current_user.respond_to? 'employee_id'
    @current_employee = TakeOffice::Employee.find(current_user.employee_id)
  end

end
