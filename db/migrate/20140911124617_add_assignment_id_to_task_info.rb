class AddAssignmentIdToTaskInfo < ActiveRecord::Migration
  def change
    change_table :task_infos do |t|
      t.string :assignment_id
    end
  end
end
