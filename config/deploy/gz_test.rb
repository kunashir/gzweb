set :stage, :gz_test

server '54.194.27.167', user: 'ubuntu', roles: %w{web app db}, primary: true

#PUMA CONF
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'gz_test'))
#


set :ssh_options, {
  forward_agent: true,
  keys: %w(/home/ubuntu/) # ключ 
  # password: 'please use keys'
}


usr = 'ubuntu' #Юзер, за которого идёт деплой
set :tmp_dir, "/home/#{usr}/tmp"


#rvm
set :rvm_type, :user
set :rvm_ruby_version, '1.9.3-p484'
