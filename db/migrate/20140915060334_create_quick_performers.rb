class CreateQuickPerformers < ActiveRecord::Migration
  def change
    create_table :quick_performers do |t|
      t.string :employee_id, index: true
      t.references :user, index: true
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
