class ChangeTaskContentToText < ActiveRecord::Migration
  def up
  	change_column :task_infos, :content, :text
  end
  
  def down
  	change_column :task_infos, :content, :string
  end
end
