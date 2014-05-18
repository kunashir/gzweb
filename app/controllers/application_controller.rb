class ApplicationController < ActionController::Base

  def current_user
    if request[:current_user].nil?
      request[:current_user] = User.new
      request[:current_user].id = session[:user_id]
    end
    request[:current_user]
  end

end
