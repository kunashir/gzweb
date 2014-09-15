class SessionsController < Devise::SessionsController 

  def new
    puts "FLASH: #{flash.inspect}"
    puts "PARAMS: #{params.inspect}"
    @users = User.all
    super
  end

  def create
    puts "PARAMS: #{params.inspect}"
    super
  end

end 