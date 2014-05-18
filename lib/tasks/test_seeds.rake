# encoding: UTF-8

namespace :db do
  namespace :test do
    task :load => :environment do
      system('rake db:seed RAILS_ENV=test')
    end
  end
end