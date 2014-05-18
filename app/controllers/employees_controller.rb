class EmployeesController < ApplicationController

  def find
    if params[:filter].blank?
      render json: { error: "Search filter is not specified" }, status: 400
      return
    end
    employees = TakeOffice::Employee.search(params[:filter])
    render json: { employees: employees.map { |x| { id: x.RowID, name: x.DisplayString } } }
  end

end