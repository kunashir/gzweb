class QuickPerformer < ActiveRecord::Base
  belongs_to :employee, class_name: 'TakeOffice::Employee'
  belongs_to :user
end
