name             'minutely_mapnik'
maintainer       'Mapzen'
maintainer_email 'grant@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures mapzen_minutely_mapnik'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w(
  osmosis
  osm2pgsql
  sysctl
  user
).each do |dep|
  depends dep
end

%w(ubuntu).each do |os|
  supports os
end
