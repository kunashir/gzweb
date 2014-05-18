class CreateTaskFiles < ActiveRecord::Migration
  def change
    create_table :task_files do |t|
      t.string :file_id
      t.string :filename

      t.belongs_to :task_info
    end
  end
end
