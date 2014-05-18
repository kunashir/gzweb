FactoryGirl.define do
  factory :task_list do
    skip_create

    factory :task_list_dummy do

      initialize_with { new([FactoryGirl.create(:task_info_dummy1), FactoryGirl.create(:task_info_dummy2)]) }
    end
  end
end