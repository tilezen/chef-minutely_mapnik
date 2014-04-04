#
# Cookbook Name:: minutely_mapnik
# Recipe:: structure
#
# Copyright 2014, Mapzen
#
# All rights reserved - Do Not Redistribute
#

directory node[:minutely_mapnik][:basedir] do
  owner   node[:minutely_mapnik][:user]
  group   node[:minutely_mapnik][:user]
  mode    0755
end

%w(bin logs osmosis).each do |d|
  directory "#{node[:minutely_mapnik][:basedir]}/#{d}" do
    owner   node[:minutely_mapnik][:user]
    group   node[:minutely_mapnik][:user]
    mode    0755
  end
end
