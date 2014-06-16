class ProcessVariable < ActiveRecord::Base
  self.table_name = 'dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}'
  # self.primary_key = 'RowID'

  before_create :assign_id
  # has_many :values, class_name: :ProcessVariableValue, primary_key: 'RowID', foreign_key: 'ParentRowID'

  # def instance_id
  #   self.InstanceID
  # end

  # def instance_id=(value)
  #   self.InstanceID = value
  #   self.values.each { |x|
  #     x.instance_id = value
  #   }
  # end

  protected

  def assign_id
    self.RowID ||= SecureRandom.uuid
  end

end