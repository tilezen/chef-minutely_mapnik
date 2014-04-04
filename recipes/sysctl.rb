#
# Cookbook Name:: minutely_mapnik
# Recipe:: sysctl
#

sysctl_param 'vm.overcommit_memory' do
  value 1
end
