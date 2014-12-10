class AddControllerToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :controller_id
  	end  	
  end
end
