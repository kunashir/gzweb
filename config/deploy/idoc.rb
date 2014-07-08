set :stage, :idoc

# server 'localhost', user: 'quercus', roles: %w{web app db}, primary: true
server 'localhost', user: 'quercus', roles: %w{web app db}, primary: true

# PUMA CONF
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'idoc'))

###########
usr = 'quercus' #Юзер, за которого идёт деплой
set :tmp_dir, "/home/#{usr}/tmp"

set :ssh_options, {
  forward_agent: true,
  keys: %w(/home/quercus/.ssh/id_rsa)
  # password: 'please use keys'
}


#rvm
set :rvm_type, :user
set :rvm_ruby_version, '1.9.3-p484'
 