class CreateTaskInfoTable < ActiveRecord::Migration
  def change
    create_table :task_infos do |t|
      t.string :task_id
      t.string :author_id
      t.string :author_name
      t.string :author_position
      t.string :controler_id
      t.string :controler_name
      t.string :controler_position
      t.string :delegated_to
      t.string :subject
      t.string :content
      t.datetime :deadline
      t.datetime :date
      t.integer :task_state
      t.integer :state
      t.integer :type
      t.string :parent_document_id
      t.string :parent_document
    end
  end
end
