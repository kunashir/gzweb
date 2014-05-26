User.create_demo_user unless ActiveRecord::Migrator.needs_migration?(ActiveRecord::Base.connection)
