#
# Cookbook Name:: minutely_mapnik
# Recipe:: default
#

%w(
  apt::default
  minutely_mapnik::structure
  minutely_mapnik::user
  minutely_mapnik::config
  minutely_mapnik::deps
  minutely_mapnik::cron
).each do |r|
  include_recipe r
end
