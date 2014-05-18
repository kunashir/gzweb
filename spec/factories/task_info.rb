#encoding: UTF-8

FactoryGirl.define do 
  factory :task_info do
    skip_create

    factory :task_info_dummy1 do
      id "C10B0DEC-1234-5678-ABCD-000000000001"
      author "Сидоренков А.Ю."
      date Time.new(2013, 04, 13, 0, 0, 0, 0)
      doc_number "2/2014"
      subject "Исходящий документ подписан"
      content "Распечатайте пожалуйста и отсканируйте копию исходящего документа."
    end

    factory :task_info_dummy2 do
      id "C10B0DEC-1234-5678-ABCD-000000000002"
      author "Мирошин К.К."
      date Time.new(2013, 04, 15, 0, 0, 0, 0)
      doc_number "6/2014"
      subject "Поручение от 10.02.2013"
      content "Проверить работу web-решения для работы с поручениями в ГОЗНАК"
      deadline Time.new(2014, 05, 12, 18, 0, 0, 0)
      delegated_to "Богданов Д.А."
    end
  end
end