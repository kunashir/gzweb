# config valid only for Capistrano 3.1
lock '3.1.0'
application = 'GZWeb' #название приложения

rpsec_log_path = "/var/www/apps/#{application}/shared/log/test.html"
# set :repo_url,  "http://sergey.pleshanov:mirea2014@code.quercus.ru/git/gzweb.git"
# set :repo_url,  "file:///home/quercus/GZWeb/.git"
set :repo_url, "https://github.com/kunashir/gzweb.git"
set :branch, "master"
# set :deploy_to, "/var/www/apps/#{application}" 
set :deploy_to, "/home/dvwp/apps/#{application}" 

set :log_level, :debug
set :keep_releases, 5
set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets}
set :bundle_without, nil 

set :application, '#{application}'
set :rails_env,   "idoc"

# #FOR PUMA
#     set :puma_rackup, -> { File.join(current_path, 'config.ru') }
#     set :puma_state, "#{shared_path}/tmp/pids/puma.state"
#     set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
#     set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
#     set :puma_conf, "#{shared_path}/puma.rb"
#     set :puma_access_log, "#{shared_path}/log/puma_error.log"
#     set :puma_error_log, "#{shared_path}/log/puma_access.log"
#     set :puma_role, :app
#     set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
#     set :puma_threads, [0, 16]
#     set :puma_workers, 0
#     set :puma_init_active_record, false
#     set :puma_preload_app, true
# ############


namespace :nginx do 
  desc 'Restart nginx'
  task :restart do
    on roles(:app) do 
      execute :sudo, 'service nginx restart'
    end
  end

end

namespace :puma do 
  desc 'Delete puma.rb config before setup'
  task :del_conf do
    on roles(:app) do 
      execute "rm /var/www/apps/#{application}/shared/puma.rb"
    end
  end
end

# namespace :tester do
#   desc 'Tester run app tests and check to '
#     task :check_specs do
#       on roles(:app) do
#         info "  Running check_specs task"
#         begin
#           system("cd #{release_path} && rake db:migrate RAILS_ENV=test") or raise "Migration on test DB failed"
#           system("cd #{release_path} && rspec spec --format html --out #{rpsec_log_path}") or raise "One or more specs are failing. Come back when they all pass."
#           @failed = false
#         rescue Exception => e
#           puts e
#           @failed = true
#         end

     
#         if @failed
#           #Net::HTTP.post_form(URI('http://smsc.ru/testsms/'), phone: '+79057526007')  #тестовые сообщения :D
#           #Net::HTTP.post_form(URI('http://smsc.ru/testsms/'), phone: '+79265604676')
#           info "  Sending notify about failed deployment to e-mail's"
#           Notifier.send("#{fetch(:stage)}_failed_notify") or raise "SENDING FAILED!"
#           info "  Deploy aborting..."
#           abort  #abotring deploy
#         else 
#           info " All rspec tests passed"
#         end
#       end
#     end
# end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Setup'
  task :setup do
    on roles(:all) do
      # upload!('shared/nginx.conf', "#{shared_path}/nginx.conf")
      # # upload!('shared/puma.rb', "#{shared_path}/puma.rb")

      # execute :sudo, 'service nginx stop'
      # execute :sudo, 'rm -f /usr/local/nginx/conf/nginx.conf'
      # execute :sudo, 'ln -s #{shared_path}/nginx.conf /usr/local/nginx/conf/nginx.conf'
      # execute :sudo, 'service nginx start'

      #нужный mkdir: /var/www/apps/#{application}/current/public/log/


      #Сюда можно впихнуть какой-то сценарий для создания базы данных при deploy:setup
      # within release_path do
      #   with rails_env: fetch(:rails_env) do
      #     execute :rake, "db:create"
      #   end
      # end



    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      # execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      # execute "ln -s #{shared_path}/Procfile #{release_path}/Procfile"
      # execute "ln -s #{shared_path}/tmp/sockets #{release_path}/tmp/sockets"
      # execute "ln -s #{shared_path}/tmp/pids #{release_path}/tmp/pids"
      # execute "ln -s #{shared_path}/log #{release_path}/log"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
  # after 'bundler:install', 'tester:check_specs'
  #after 'deploy:cleanup', 'tester:check_specs'

  # after 'puma:smart_restart', 'nginx:restart'
  # after 'puma:start', 'nginx:restart'
  # after 'puma:stop', 'nginx:restart'

  # after :updating, 'deploy:symlink'
  
  before :setup, 'puma:del_conf'
  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'

end
