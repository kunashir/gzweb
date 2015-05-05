set :stage, :idoc

# server 'localhost', user: 'dvwp', roles: %w{web app db}, primary: true
server 'dv.idoc.ru:2222', user: 'dvwp', roles: %w{web app db}, primary: true

# PUMA CONF
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'idoc'))

###########
usr = 'dvwp' #Юзер, за которого идёт деплой
set :tmp_dir, "/home/#{usr}/tmp"

# set :ssh_options, {
#   forward_agent: true,
#   keys: %w(/home/dvwp/.ssh/id_rsa)
#   # password: 'please use keys'
# }


#rvm
set :rvm_type, :user
set :rvm_ruby_version, '1.9.3-p547'
 