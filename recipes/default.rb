#
# Cookbook Name:: minutely_mapnik
# Recipe:: default
#
# Copyright 2014, Mapzen
#
# All rights reserved - Do Not Redistribute
#

%w(
  minutely_mapnik::sysctl
  minutely_mapnik::structure
  minutely_mapnik::user
  minutely_mapnik::config
  minutely_mapnik::deps
  minutely_mapnik::cron
).each do |r|
  include_recipe r
end
