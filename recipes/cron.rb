#
# Cookbook Name:: minutely_mapnik
# Recipe:: cron
#
# Copyright 2014, Mapzen
#
# All rights reserved - Do Not Redistribute
#

cron 'minutely mapnik' do
  action  :create
  minute  node[:minutely_mapnik][:cron][:minute]
  hour    node[:minutely_mapnik][:cron][:hour]
  day     node[:minutely_mapnik][:cron][:day]
  user    node[:minutely_mapnik][:user]
  command "#{node[:minutely_mapnik][:basedir]}/bin/update.sh >#{node[:minutely_mapnik][:basedir]}/logs/update.out 2>&1"
  only_if { node[:minutely_mapnik][:cron][:enable] == true }
end
