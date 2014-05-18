#encoding: UTF-8
class User < CacheBase

  has_one :tasks_info
  has_many :task_infos

  # def initialize
  #   self.first_name = "Кирилл"
  #   self.last_name = "Мирошин"
  #   self.display_name = "Мирошин К. Г."
  # end

  def ==(other)
    id == other.id
  end 

  def to_s
    display_name
  end

  def self.create_demo_user
    u = User.first || User.new
    u.last_name = 'Трачук'
    u.first_name = 'Аркадий'
    u.middle_name = 'Владимирович'
    u.display_name = 'Трачук Аркадий Владимирович'
    u.position = 'Генеральный директор ФГУП "Гознак"'
    if u.respond_to? 'employee_id='
      u.employee_id = '423C7538-AC52-46DC-946C-7DECF5176BFE'
      u.employee_id = 'BAB94E8C-A3C8-4DDE-93CB-8AD829B91B1A'
    end
    if u.respond_to? 'account_name='
      u.account_name = 'dvvm\\Администратор'
    end
    u.save
  end
end