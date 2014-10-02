class RenameTypeToTaskType < ActiveRecord::Migration
  def change
    rename_column :task_infos, :type, :task_type
  end
end
