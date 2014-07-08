FactoryGirl.define do
    factory :tasks_info do
        skip_create

        performing 10
        performing_new 2
        to_accept 1
        to_accept_new 0
        long_tasks 4
        long_tasks_new 1
        to_approve 5
        to_approve_new 0
        to_sign 0
        to_sign_new 0
        informational 8
        informational_new 6
        issued 5
        issued_new 1
        long_issued 2
        long_issued_new 0
        delegated 45
        delegated_new 17
        overdue 10
        upcoming 6
        controlled 3
    end
end