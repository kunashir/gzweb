# encoding: UTF-8

class ProcessCard

  attr_reader :instance, :main_info, :variables

  delegate :id, to: :instance, allow_nil: true
  delegate :sid, to: :instance, allow_nil: true
  delegate :sid=, to: :instance, allow_nil: true
  delegate :description, to: :instance, allow_nil: true
  delegate :description=, to: :instance, allow_nil: true

  def initialize(instance = nil)
    if instance.nil?
      @instance = Card.new(CardTypeID: CardType.process)
      @instance.assign_id
    else
      @instance = instance
    end

    @main_info = ProcessMainInfo.where(InstanceID: id).first ||
      ProcessMainInfo.new(InstanceID: id)
  end

  def find_variable(name)
    connection = ActiveRecord::Base.connection
    var = connection.exec_query("SELECT TOP(1) RowID FROM [dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] WHERE InstanceID = '#{id}' AND Name='#{name}'").first
    unless var.nil?
      var["RowID"]
    else
      nil
    end
  end

  def start
    self.main_info.DateBegin = Time.now + Time.zone_offset(Time.now.zone)
    self.description = self.description + " (Активен)"
    self.main_info.State = 1
    self.main_info.ReadyToRun = true

    init_query = <<-query
      insert into 
        [dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}]
        (RowID, ParentRowID, ParentTreeRowID, InstanceID, State, Data)
      select
        NEWID() as RowID,
        func.RowID as ParentRowID,
        '00000000-0000-0000-0000-000000000000' as ParentTreeRowID,
        func.InstanceID as InstanceID,
        1 as State,
        func.Data as Data
      from 
        [dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] func
        LEFT JOIN [dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] funcstate
          ON funcstate.ParentRowID = func.RowID
      where 
        func.InstanceID = '#{self.id}'
        and func.TypeID = '0C658CC7-E2E7-4E47-99A3-FEE40CF67367'
        and funcstate.ParentRowID is null
    query
    ActiveRecord::Base.connection.execute(init_query)

    save!
  end

  def self.all
    Card.where(CardTypeID: CardType.process).
      map { |x| ProcessCard.new(x) }
  end

  def self.first
    instance = Card.where(CardTypeID: CardType.process).first
    return ProcessCard.new(instance) unless instance.nil?
    return nil
  end

  def self.find(id)
    instance = Card.where(CardTypeID: CardType.process, InstanceID: id).first
    return ProcessCard.new(instance) unless instance.nil?
    return nil
  end

  def save!
    @instance.save!
    @main_info.instance_id = self.id
    @main_info.save!
  end

end