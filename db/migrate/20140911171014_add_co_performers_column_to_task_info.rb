class AddCoPerformersColumnToTaskInfo < ActiveRecord::Migration
  def change
  	change_table :task_infos do |t|
  		t.string :co_performers
  	end
  end
end
