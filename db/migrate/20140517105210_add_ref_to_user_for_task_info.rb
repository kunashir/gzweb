class AddRefToUserForTaskInfo < ActiveRecord::Migration
  def change
    change_table :task_infos do |t|
      t.string :folder, index: true
    end
    add_reference :task_infos, :user, index: true
  end
end
