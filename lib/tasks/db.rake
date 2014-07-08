# encoding: UTF-8
Rake::Task["db:test:prepare"].clear

namespace :db do
  namespace :test do
    task :prepare => [:environment, :load_config] do
      unless ActiveRecord::Base.configurations.blank?
        begin
          should_reconnect = ActiveRecord::Base.connection_pool.active_connection?
          current_env = Rails.env
          Rails.env = 'test'
          ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
          ActiveRecord::Schema.verbose = false
          Rake::Task["db:schema:load"].invoke
          load("#{Rails.root}/lib/docs_vision_schema.rb")
          load("#{Rails.root}/db/migrate/20140704043802_add_stored_procedures_to_test.rb")
          sp_migration = AddStoredProceduresToTest.new
          sp_migration.exec_migration(ActiveRecord::Base.connection, :up)
          ActiveRecord::Tasks::DatabaseTasks.load_seed
        ensure
          if should_reconnect
            ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[ActiveRecord::Tasks::DatabaseTasks.env])
          end
          Rails.env = current_env
        end
      end
    end
  end
end