class SetFirstUserQuickPerformers < ActiveRecord::Migration
  def change
    u = User.first
    unless u.nil?
      u.quick_performers.destroy_all
      index = 0
      TakeOffice::Employee.quick_performers.each { |employee| 
        u.quick_performers << QuickPerformer.create!(employee: employee, order: index)
        index += 1
      }
    end
  end
end
