class AddMiddleNameToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :middle_name
    end
  end
end
