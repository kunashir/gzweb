class AddAutorefreshFieldsToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.datetime :last_refresh_date
  		t.integer :refresh_minutes
  	end
  end
end
