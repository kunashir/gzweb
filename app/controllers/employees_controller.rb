require 'mime_image_type'

class EmployeesController < ApplicationController

  def find
    if params[:filter].blank?
      render json: { error: "Search filter is not specified" }, status: 400
      return
    end
    employees = TakeOffice::Employee.search(params[:filter])
    render json: { employees: employees.map { |x| { id: x.RowID, name: x.DisplayString } } }
  end

  def photo
    employee = TakeOffice::Employee.find(params[:id])
    file = employee.photos.first unless employee.nil?
    raise ActionController::RoutingError.new('Not Found') if file.nil?
    send_data file.Picture, type: Mime::Type.lookup_by_image_content(file.Picture).to_s, disposition: :inline
  end

end