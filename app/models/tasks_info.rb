class TasksInfo < CacheBase
  self.table_name = "tasks_info"

  belongs_to :user
  after_initialize :init_fields

  def init_fields
    self.performing ||= 0
    self.performing_new ||= 0
    self.to_accept ||= 0
    self.to_accept_new ||= 0
    self.long_tasks ||= 0
    self.long_tasks_new ||= 0
    self.to_approve ||= 0
    self.to_approve_new ||= 0
    self.to_sign ||= 0
    self.to_sign_new ||= 0
    self.informational ||= 0
    self.informational_new ||= 0
    self.issued ||= 0
    self.issued_new ||= 0
    self.long_issued ||= 0
    self.long_issued_new ||= 0
    self.delegated ||= 0
    self.delegated_new ||= 0
    self.overdue ||= 0
    self.upcoming ||= 0
    self.controlled ||= 0
  end

  def self.get(employee)
    employee.tasks_info || TasksInfo.new
  end

  def self.recount(employee)
    tasks_info = employee.tasks_info
    if tasks_info.nil?
      tasks_info = TasksInfo.new
      tasks_info.user = employee
      employee.tasks_info = tasks_info
    end
    [:performing, :to_accept, :to_approve, 
      :to_sign, :informational, :delegated].each do |filter| 
      existing_tasks = employee.task_infos.where(folder: filter).to_a
      total_count = existing_tasks.length
      new_count = existing_tasks.select { |x| x.is_new }.length
      tasks_info.send("#{filter}=", total_count)
      tasks_info.send("#{filter}_new=", new_count)
    end
    tasks_info.save!
  end

  @@sync_lock = Mutex.new
  @@user_sync_locks = {}

  def self.sync_all_if_needed
    users_to_sync = User.where('last_refresh_date is null or (last_refresh_date + ISNULL(refresh_minutes, 15)/24.0/60.0 < ?)', DateTime.now)
    users_to_sync.each do |user|
      sync(user)
    end
  end

  def self.sync(user)
    @@sync_lock.synchronize do
      unless @@user_sync_locks.key?(user.employee_id)
        @@user_sync_locks[user.employee_id] = Mutex.new
      end
    end
    user_lock = @@user_sync_locks[user.employee_id]
    user_lock.synchronize do
      if user.last_refresh_date.nil? ||
         (DateTime.now.to_time - user.last_refresh_date > 15) # refreshing faster than once per 15-second is forbidden
        sql_connection = ActiveRecord::Base.connection
        tasks = sql_connection.execute_procedure(
          '[dvreport_get_data_{8c688b6c-5e83-4208-a795-368d067c29eb}]',
          user.employee_id,
          user.account_name)
        tasks_info = user.tasks_info
        user.transaction do
          if tasks_info.nil?
            tasks_info = TasksInfo.new
            tasks_info.user = user
            user.tasks_info = tasks_info
          end
          [:performing, :to_accept, :to_approve, 
            :to_sign, :informational, :delegated].each do |filter| 
            existing_tasks = user.task_infos.where(folder: filter).to_a
            total_count = 0
            new_count = 0
            tasks.select { |x| TasksInfo.send("is_#{filter}", x, user) }.each do |task|
              total_count += 1
              if is_new(task)
                new_count += 1
              end
              cache_task = existing_tasks.select { |x| x.task_id == task[:TaskID] }.first
              if cache_task.nil?
                cache_task = TaskInfo.new
                cache_task.task_id = task[:TaskID]
                cache_task.user = user
                cache_task.folder = filter
              else
                existing_tasks.delete(cache_task)
              end
              fill_task_fields(cache_task, task)
              cache_task.save
            end
            existing_tasks.each { |x| x.destroy }
            tasks_info.send("#{filter}=", total_count)
            tasks_info.send("#{filter}_new=", new_count)
          end
          tasks_info.save
          user.last_refresh_date = DateTime.now
          user.save
        end
      end
    end
    return user.tasks_info
  end

  def self.reload_task(id, user) 
    sql_connection = ActiveRecord::Base.connection
    tasks = sql_connection.execute_procedure(
      '[dvreport_get_data_{8c688b6c-5e83-4208-a795-368d067c29eb}]',
      user.employee_id,
      user.account_name)
    task = tasks.first { |x| x[:TaskID] == id }
    cache_task = TaskInfo.where(task_id: id).first
    fill_task_fields(cache_task, task)
    cache_task.save
  end

  def self.fill_task_fields(cache_task, task)
    cache_task.is_new = task[:IsNew]
    cache_task.subject = task[:TaskSubject]
    cache_task.content = task[:TaskContents]
    cache_task.author_name = task[:TaskAuthor]
    unless task[:TaskDate].nil?
      cache_task.date = task[:TaskDate] + Time.zone_offset(task[:TaskDate].zone)
    else
      cache_task.date = nil
    end
    unless task[:TaskEndDate].nil?
      cache_task.deadline = task[:TaskEndDate] + Time.zone_offset(task[:TaskEndDate].zone)
    else
      cache_task.deadline = nil
    end
    cache_task.delegated_to = task[:AssignedTo]
    cache_task.task_state = task[:TaskState]
    cache_task.state = task[:AssignmentState]
    cache_task.task_type = task[:AssignmentType]
    fields = get_task_fields(cache_task, task).first
    return if fields.nil?
    puts fields.inspect
    cache_task.author_id = fields["AuthorID"]
    cache_task.author_name = fields["AuthorName"]
    cache_task.author_position = fields["AuthorPosition"]
    cache_task.controler_id = fields["ControlerID"]
    cache_task.controler_name = fields["ControlerName"]
    cache_task.controler_position = fields["ControlerPosition"]
    cache_task.parent_document_id = fields["DocumentID"]
    cache_task.parent_document = fields["Document"]
    cache_task.assignment_id = fields["AssignmentID"]
    cache_task.co_performers = fields["CoPerformers"]

    cache_task.kind = nil

    if !fields["DocumentTypeID"].nil? &&
       CardType.incdoc_type_id.casecmp(fields["DocumentTypeID"]) == 0 && 
       cache_task.task_type == 5
      cache_task.kind = :incdoc_reviewal
    end
    if !fields["DocumentTypeID"].nil? &&
       CardType.memorandum_type_id.casecmp(fields["DocumentTypeID"]) == 0 && 
       cache_task.task_type == 5
      cache_task.kind = :memorandum_reviewal
    end

    load_task_files(cache_task)
  end

  def self.get_task_fields(cache_task, task)
    query = <<-SQL
      SELECT 
        author.RowID as AuthorID, 
        author.DisplayString as AuthorName, 
        authorPosition.Name as AuthorPosition,
        controler.RowID as ControlerID, 
        controler.DisplayString as ControlerName, 
        controlerPosition.Name as ControlerPosition,
        document.InstanceID as DocumentID,
        document.Description as Document,
        document.CardTypeID as DocumentTypeID,
        CAST(taskProperty.Value as uniqueidentifier) as AssignmentID,
        (SELECT employee.DisplayString + 
                CASE
                  WHEN position.name is null THEN
                    ''
                  ELSE
                    '@@' + position.name
                 END + '||'
         FROM   [dvtable_{0CE329FC-33E8-4D10-B717-562B7FC1208D}] co_performer
                JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] employee
                  ON employee.RowID = co_performer.coperformer
                LEFT JOIN [dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}] position WITH(NOLOCK)
                  ON position.RowID = employee.Position
         WHERE  co_performer.InstanceID = CAST(taskProperty.Value as uniqueidentifier)
         FOR XML PATH('')) as CoPerformers
      FROM
        [dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] taskMain WITH (NOLOCK)
        LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] author WITH(NOLOCK)
          ON author.RowID = taskMain.CreatedBy
        LEFT JOIN [dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}] authorPosition WITH(NOLOCK)
          ON authorPosition.RowID = author.Position
        LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] controler WITH(NOLOCK)
          ON controler.RowID = '#{task[:Controller] || '00000000-0000-0000-0000-000000000000'}'
        LEFT JOIN [dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}] controlerPosition WITH(NOLOCK)
          ON controlerPosition.RowID = controler.Position
        LEFT JOIN [dvtable_{ECA843EF-2810-4795-A81A-B047F76250EC}] taskRefs WITH(NOLOCK)
          ON taskRefs.InstanceID = taskMain.InstanceID AND taskRefs.OpenImmediately = 1
        LEFT JOIN [dvsys_instances] document WITH (NOLOCK)
          ON document.InstanceID = taskRefs.RefID and document.CardTypeID <> '{FFF11133-DFC4-4CD6-A2D4-BD242E2A4670}'
        LEFT JOIN [dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] taskProperty WITH (NOLOCK)
          ON taskProperty.InstanceID = taskMain.InstanceID and taskProperty.Name = 'ParentAssignment'
      WHERE
        taskMain.InstanceID = '#{cache_task.task_id}'
    SQL
    ActiveRecord::Base.connection.select_all(query)
  end

  def self.load_task_files(cache_task)
    files = get_task_files(cache_task)
    existing_files = cache_task.task_files
    to_remove_files = existing_files.to_a
    files.each do |file|
      cache_file = existing_files.select { |x| x.file_id == file["FileID"] }.first
      if cache_file.nil?
        cache_file = TaskFile.new
        cache_file.task_info = cache_task
        cache_file.file_id = file["FileID"]
        cache_file.filename = file["FileName"]
        cache_file.save
      else
        to_remove_files.delete(cache_file)
      end
    end
    to_remove_files.each { |file| file.destroy }
  end

  def self.get_task_files(cache_task)
    card_id = cache_task.parent_document_id || cache_task.task_id
    query = <<-query
        SELECT
          cardfile.FileName as FileName,
          cardfile.InstanceID as FileID
        FROM
          dvsys_links link WITH (NOLOCK)
          JOIN [dvtable_{E962AC85-0F53-4439-A1CD-171E46C3EF91}] filelist WITH(NOLOCK)
            ON filelist.InstanceID = link.DestinationCardID
          JOIN [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] cardfile WITH(NOLOCK)
            ON cardfile.InstanceID = filelist.CardFileID
        WHERE
          link.SourceCardID = '#{card_id}'
      query
      ActiveRecord::Base.connection.select_all(query)
    end

  def self.is_performing(task_info, employee)
    return false unless task_info[:AssignedTo].blank?
    return false if task_info[:AssignmentType] == 2
    return true if task_info[:IsNRDToCert] == 1
    return true if is_scan_task(task_info)
    return true if task_info[:ToRegister] == 1 && task_info[:ToRead] != true
    return false if task_info[:AssignmentState] == 5
    return is_common_task(task_info)
  end

  def self.is_to_accept(task_info, employee)
    return task_info[:AssignmentState] == 5
    # in C# there's test for the next line, but it seems that it's written wrong and is invalid
    # || task_info[:Controller] == employee.employee_id
  end

  def self.is_delegated(task_info, employee)
    return !task_info[:AssignedTo].blank?
  end

  def self.is_to_approve(task_info, employee)
    return false unless task_info[:ToApprove] == 1
    return false unless task_info[:AssignedTo].blank?
    return false if task_info[:AssignmentState] == 5
    return false if task_info[:ToRead] == true
    return false if task_info[:IsIncoming] == 1
    return false if task_info[:IsMemorandum] == 1
    return !is_common_task(task_info)
  end

  def self.is_to_sign(task_info, employee)
    return false unless task_info[:ToSign] == 1
    return false unless task_info[:AssignedTo].blank?
    return false if task_info[:AssignmentState] == 5
    return false if task_info[:ToRead] == true
    return !is_common_task(task_info)    
  end

  def self.is_informational(task_info, employee)
    return false unless task_info[:ToRead] == true
    return false unless task_info[:AssignedTo].blank?
    return false unless task_info[:ParentTaskID].blank?
    return false if task_info[:AssignmentState] == 5
    return !is_common_task(task_info) || task_info[:AssignmentType] == 2
  end

  def self.is_scan_task(task_info)
    return task_info[:TaskEndDate].nil? &&
           task_info[:ToRead].nil? &&
           task_info[:Controller].nil? &&
           task_info[:AssignmentState].nil? &&
           task_info[:ParentTaskID].nil? &&
           task_info[:AssignmentType].nil? &&
           task_info[:Control].nil? &&
           task_info[:AssignedTo].nil? &&
           task_info[:ToApprove] == 0 &&
           task_info[:ToSign] == 0 &&
           task_info[:IsIncoming].nil? &&
           task_info[:IsMemorandum].nil? &&
           task_info[:ToRegister].nil?;
  end

  def self.is_common_task(task_info)
    return !task_info[:AssignmentState].nil? ||
           !task_info[:AssignmentType].nil? ||
           !task_info[:ParentTaskID].blank?
  end

  def self.is_new(task_info)
    return task_info[:IsNew] == 1
  end

  protected

  def self.rnd
    @@rnd ||= Random.new
  end

  def load(employee)
    if employee.nil? || employee.id.nil?
      load_random
    end
    self
  end

  def load_random
    { performing: 10, to_accept: 8, long_tasks: 4,
      to_approve: 5, to_sign: 3, informational: 8,
      issued: 12, long_issued: 4, delegated: 30 }.each { |prop, max|
        value = TaskInfo.rnd.rand(max)
        send("#{prop}=", value)
        send("#{prop}_new=", value == 0 ? 0 : TaskInfo.rnd.rand(value))
      }
    self
  end

end