# minutely_mapnik
#
default[:minutely_mapnik][:basedir] = '/opt/minutely_mapnik'
default[:minutely_mapnik][:user]    = 'mapnik'

# configuration.txt
#
default[:minutely_mapnik][:cfg_txt][:stream]        = 'minute' # one of: minute, hour, day
default[:minutely_mapnik][:cfg_txt][:max_interval]  = 3600

# state.txt
#   You MUST supply initial values
#   for day/month/year.
#
default[:minutely_mapnik][:state_txt][:minute]  = 00  # two digits, e.g. 24 for XX:24
default[:minutely_mapnik][:state_txt][:hour]    = 00  # two digits, e.g. 10 for 10am
default[:minutely_mapnik][:state_txt][:day]     = nil # two digits, e.g. 01 for monday
default[:minutely_mapnik][:state_txt][:month]   = nil # two digits, e.g. 10 for october
default[:minutely_mapnik][:state_txt][:year]    = nil # four digits, e.g. 2014

# cron
#   Defaults to every minute.
#
default[:minutely_mapnik][:cron][:enable] = true
default[:minutely_mapnik][:cron][:minute] = '*'
default[:minutely_mapnik][:cron][:hour]   = '*'
default[:minutely_mapnik][:cron][:day]    = '*'

# postgres
#   Defaults will only ensure we don't accidentally
#   connect to a running database.
#
default[:minutely_mapnik][:postgres][:endpoint] = 'localhost'
default[:minutely_mapnik][:postgres][:database] = 'gis'
default[:minutely_mapnik][:postgres][:username] = 'gis'
default[:minutely_mapnik][:postgres][:password] = ''

# osm2pgsql
#
default[:minutely_mapnik][:osm2pgsql][:num_processes] = node[:cpu][:total]
# if present, will execute post import, but before freeing lock
default[:minutely_mapnik][:osm2pgsql][:post_import] = nil
