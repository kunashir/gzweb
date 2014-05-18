class CreateTaskInfo < ActiveRecord::Migration
  def change
    create_table :tasks_info do |t|
      t.integer :performing
      t.integer :performing_new
      t.integer :to_accept
      t.integer :to_accept_new
      t.integer :long_tasks
      t.integer :long_tasks_new
      t.integer :to_approve
      t.integer :to_approve_new
      t.integer :to_sign
      t.integer :to_sign_new
      t.integer :informational
      t.integer :informational_new
      t.integer :issued
      t.integer :issued_new
      t.integer :long_issued
      t.integer :long_issued_new
      t.integer :delegated
      t.integer :delegated_new
      t.integer :overdue
      t.integer :upcoming
      t.integer :controlled
    end
  end
end
