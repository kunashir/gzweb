class CreateAdminIfNotExist < ActiveRecord::Migration
  def change
    if Admin.first.nil?
      Admin.create!(login: 'admin', password: '1')
    end
  end
end
