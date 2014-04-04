#
# Cookbook Name:: minutely_mapnik
# Recipe:: user
#

user_account node[:minutely_mapnik][:user] do
  shell         '/bin/bash'
  ssh_keygen    false
  manage_home   true
  create_group  true
end
