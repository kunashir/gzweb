class AddSenderAndOrganizationToTask < ActiveRecord::Migration
  def change
  	change_table :task_infos do |t|
  		t.string :sender_person
  		t.string :sender_organization
  	end
  end
end
