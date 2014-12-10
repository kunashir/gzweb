class AddSenderPositionToTask < ActiveRecord::Migration
  def change
  	change_table :task_infos do |t|
  		t.string :sender_position
  	end
  end
end
