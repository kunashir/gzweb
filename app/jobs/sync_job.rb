class SyncJob
  @queue = :simple

  def self.perform
    User.all.each { |user| 
      puts "#{Time.now} | Synchronizing user '#{user.display_name}'"
      TasksInfo.sync(user)
    }
    puts "#{Time.now} | Sync done"
  end

end