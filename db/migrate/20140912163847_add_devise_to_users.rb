class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""
    end
    add_index :users, :account_name,                :unique => true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
