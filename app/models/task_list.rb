class TaskList
  include Enumerable

  def initialize(*items)
    @items = (items || []).flatten
  end

  def self.get(user, kind)
    if user.nil?
      TaskList.new.send(:load, user, kind)
    else
      user.task_infos.where(folder: kind)
    end
  end

  def each(*args, &block)
    @items.each(*args, &block)
  end

  def [](index)
    @items[index]
  end

  protected 

  def self.rnd
    @@rnd ||= Random.new
  end

  def load(user, kind)
    if user.nil? || user.id.nil?
      load_random
    end
    self
  end

  def load_random
    count = TaskList.rnd.rand(40) + 10
    count.times { @items << TaskInfo.random }
  end
end 