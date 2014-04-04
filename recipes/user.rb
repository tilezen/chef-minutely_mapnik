#
# Cookbook Name:: minutely_mapnik
# Recipe:: user
#
# Copyright 2014, Mapzen
#
# All rights reserved - Do Not Redistribute
#

user_account node[:minutely_mapnik][:user] do
  shell         '/bin/bash'
  ssh_keygen    false
  manage_home   true
  create_group  true
end
