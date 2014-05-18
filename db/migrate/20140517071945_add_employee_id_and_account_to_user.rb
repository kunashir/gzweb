class AddEmployeeIdAndAccountToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :employee_id
      t.string :account_name
    end
  end
end
