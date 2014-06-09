class MainController < ApplicationController
  #http_basic_authenticate_with name: "dhh", password: "secret"

  def index
    @task_info = TasksInfo.get(current_user)
    @user = current_user
    @quick_performers = TakeOffice::Employee.all.take(6)
  end

  def file
    file = DocsFile.get(params[:id])
    extname = File.extname(file.name)[1..-1]
    mime_type = Mime::Type.lookup_by_extension(extname)
    content_type = mime_type.to_s unless mime_type.nil?
    if content_type.nil?
      send_data file.data, filename: file.name, disposition: :inline
    else
      send_data file.data, filename: file.name, type: content_type, disposition: :inline
    end
  end

  def upload
    logger.debug params.inspect
    render json: { status: :ok }
  end

  def file_icon
    ext = params[:ext] || ''
    render json: { icon: ActionController::Base.helpers.asset_path(Icon.for_ext(ext)) }
  end
end