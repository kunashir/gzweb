#encoding: UTF-8
class User < CacheBase

  has_one :tasks_info
  has_many :task_infos

  def ==(other)
    id == other.id
  end 

  def to_s
    display_name
  end

  def self.create_demo_user(demo_user_data = {})
    u = User.first || User.new
    u.last_name = demo_user_data[:last_name] || 'Трачук'
    u.first_name = demo_user_data[:first_name] || 'Аркадий'
    u.middle_name = demo_user_data[:middle_name] || 'Владимирович'
    u.display_name = demo_user_data[:display_name] || 'Трачук Аркадий Владимирович'
    u.position = demo_user_data[:position] || 'Генеральный директор ФГУП "Гознак"'
    if u.respond_to? 'employee_id='
      u.employee_id = demo_user_data[:employee_id] || '422ECC62-A548-4E4F-BAB9-A12E9923DB62'
    end
    if u.respond_to? 'account_name='
      u.account_name = demo_user_data[:account_name] || 'GZ\\Trachuk'
    end
    u.save
  end
end
