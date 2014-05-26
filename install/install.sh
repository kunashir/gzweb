#!/bin/bash
# FreeTDS needed to access MSSql databases
apt-get install -y freetds-dev freetds-bin tdsodbc
# Redis is used as key-value storage for scheduler and worker process
apt-get install -y redis-server
# CURL
apt-get install -y curl
# RVM
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
apt-get install -y build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison
# Node.js
apt-get install -y nodejs
# Installin ruby
rvm install 1.9.3
rvm use 1.9.3 --default
rvm rubygems current
gem install rails



