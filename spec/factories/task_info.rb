#encoding: UTF-8

FactoryGirl.define do 
  factory :task_info do
    skip_create

    factory :task_info_dummy1 do
      id 1
      task_id "261a8630-0924-4e68-9170-f5b6def97cfe"
      author_id "577dadd4-27ba-4adb-8ea5-33e5d9cb1e43"
      author_name "Сидоренков А.Ю."
      author_position "Генерал"
      controler_id "add2cdd1-9f00-47d1-9bc5-035398fcc5a8"
      controler_name "Мирошин К.К."
      controler_position "Манагер"
      date Time.new(2013, 04, 13, 0, 0, 0, 0)
      parent_document_id "2ef64727-818b-44d5-9e2f-e57fe6361c22"
      parent_document "2/2014"
      subject "Исходящий документ подписан"
      content "Распечатайте пожалуйста и отсканируйте копию исходящего документа."
    end

    factory :task_info_dummy2 do
      id 2
      task_id "3c8bf8fc-c412-472b-b642-f590c8022902"
      author_id "add2cdd1-9f00-47d1-9bc5-035398fcc5a8"
      author_name "Мирошин К.К."
      author_position "Манагер"
      date Time.new(2013, 04, 15, 0, 0, 0, 0)
      parent_document_id "bcbce55c-c9df-4ba5-8d75-c19b558b66e6"
      parent_document "6/2014"
      subject "Поручение от 10.02.2013"
      content "Проверить работу web-решения для работы с поручениями в ГОЗНАК"
      deadline Time.new(2014, 05, 12, 18, 0, 0, 0)
      delegated_to "Богданов Д.А."
    end
  end
end