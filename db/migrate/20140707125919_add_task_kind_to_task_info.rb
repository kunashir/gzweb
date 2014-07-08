class AddTaskKindToTaskInfo < ActiveRecord::Migration
  def change
    change_table :task_infos do |t|
      t.string :kind
    end
  end
end
