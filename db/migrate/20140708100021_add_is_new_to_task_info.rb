class AddIsNewToTaskInfo < ActiveRecord::Migration
  def change
    change_table :task_infos do |t|
      t.boolean :is_new
    end
  end
end
