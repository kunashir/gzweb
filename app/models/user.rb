#encoding: UTF-8

class User < CacheBase
  devise :database_authenticatable, :rememberable

  has_one :tasks_info
  has_many :task_infos
  has_many :quick_performers

  def ==(other)
    id == other.id
  end 

  def to_s
    display_name
  end

  def first_name
    employee.try(:first_name)
  end

  def middle_name
    employee.try(:middle_name)
  end

  def last_name
    employee.try(:last_name)
  end

  def display_name
    employee.try(:display_name)
  end

  def account_name
    employee.try(:account_name) || super
  end

  def position
    employee.try(:position)
  end

  def has_photo?
    return employee.has_photo? unless employee.nil?
    return false
  end

  def employee
    @employee ||= TakeOffice::Employee.where(RowID: employee_id).first
  end

  def employee=(value)
    if value.nil?
      self.employee_id = nil
    else
      self.employee_id = value.id
    end
    @employee = value
  end

  def quick_performer_employees
    result = self.quick_performers.order(:order).map { |x| x.employee }
    if result.blank?
      result = [ employee ]
    end
    result
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

  def self.where(*args)
    if !args.nil? &&
        args.length == 1 && 
        args[0].is_a?(Hash) &&
        args[0].length == 1 &&
        args[0].keys[0] == :account_name 
      employee = TakeOffice::Employee.where('AccountName' => args[0].values[0]).first
      return [] if employee.nil?
      return self.where(employee_id: employee.id)
    end
    super
  end
end
