module ControllerMacros
  def set_user_logged_in
    before :each do 
      session[:user_id] = 'dummy'
    end
  end
end