class AddRembemerableToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
	  	# rememberable
  		t.datetime :remember_created_at
  	end
  end
end
