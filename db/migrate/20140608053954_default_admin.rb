class DefaultAdmin < ActiveRecord::Migration
  def change
    if Admin.first.nil?
      Admin.create!(login: 'admin', password: 'gzadmin')
    end
  end
end
