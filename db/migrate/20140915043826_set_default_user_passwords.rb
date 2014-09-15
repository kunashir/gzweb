class SetDefaultUserPasswords < ActiveRecord::Migration
  def change
    User.all.each { |user| 
      if user.password.nil?
        user.password = '1'
        user.save!
      end
    }
  end
end
