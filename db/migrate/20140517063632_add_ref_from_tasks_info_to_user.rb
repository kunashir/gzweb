class AddRefFromTasksInfoToUser < ActiveRecord::Migration
  def change
    add_reference :tasks_info, :user, :index => true
  end
end
