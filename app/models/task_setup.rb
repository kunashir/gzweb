require 'take_office/folder'

class TaskSetup < ActiveRecord::Base
  self.table_name = 'dvtable_{72A6CB51-AAD5-4B65-9018-BAFED95E3F96}'
  self.primary_key = 'RowID'

  belongs_to :process_folder, class_name: 'TakeOffice::Folder', primary_key: 'RowID', foreign_key: 'AssignmentBPStartingFolder'
  belongs_to :task_folder, class_name: 'TakeOffice::Folder', primary_key: 'RowID', foreign_key: 'AssignmentStoreFolder'

  def self.instance
    @@instance ||= TaskSetup.first
  end

  def self.process_template_id
    self.instance.AssignmentBPTemplate
  end

end
