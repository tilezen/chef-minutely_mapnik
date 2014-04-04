#
# Cookbook Name:: minutely_mapnik
# Recipe:: config
#

template "#{node[:minutely_mapnik][:basedir]}/bin/update.sh" do
  owner   node[:minutely_mapnik][:user]
  group   node[:minutely_mapnik][:user]
  source  'update.sh.erb'
  mode    0755
end

template "#{node[:minutely_mapnik][:basedir]}/osmosis/configuration.txt" do
  owner   node[:minutely_mapnik][:user]
  group   node[:minutely_mapnik][:user]
  source  'configuration.txt.erb'
  mode    0644
end

# rotate logs
#
template '/etc/logrotate.d/mapnik' do
  owner   'root'
  group   'root'
  source  'mapnik-logrotate.erb'
  mode    0644
end

# fetch state.txt
#
remote_file "#{node[:minutely_mapnik][:basedir]}/osmosis/state.txt" do
  source  "http://osm.personalwerk.de/replicate-sequences/?\
Y=#{node[:minutely_mapnik][:state_txt][:year]}&\
m=#{node[:minutely_mapnik][:state_txt][:month]}&\
d=#{node[:minutely_mapnik][:state_txt][:day]}&\
H=#{node[:minutely_mapnik][:state_txt][:hour]}&\
i=#{node[:minutely_mapnik][:state_txt][:minute]}&\
s=#{node[:minutely_mapnik][:state_txt][:second]}&\
stream=#{node[:minutely_mapnik][:state_txt][:stream]}#"
  owner   node[:minutely_mapnik][:user]
  group   node[:minutely_mapnik][:user]
  mode    0644
  not_if  { ::File.exist?("#{node[:minutely_mapnik][:basedir]}/osmosis/state.txt") }
end
