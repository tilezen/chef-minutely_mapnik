Minutely_Mapnik Chef Cookbook
=============================

Current Build Status
--------------------
[![Build Status](https://secure.travis-ci.org/mapzen/chef-minutely_mapnik.png)](http://travis-ci.org/mapzen/chef-minutely_mapnik)

Description
-----------
Installs minutely_mapnik
* website: https://github.com/mapzen/chef-minutely_mapnik.git

Usage
-----
    include_recipe 'minutely_mapnik'

The cookbook performs the following functions:
* creates a directory hierarchy into which the setup will be installed
* creates a user under which updates will be run
* installs osmosis and osm2pgsql, tools which are required to retrive and apply updates to an OSM PostGIS database
* creates the state.txt and configuration.txt files that osmosis will use to manage updates
* supplies a sample template, update.sh.erb, which you'll likely want to override in whole or in part. In future, this will perhaps be made more modular.

You will need to supply the following in your wrapper cookbook to generate a sane state.txt/configuration.txt. The state.txt file is used by osmosis to determine how far back it should go to start fetching updates. If you haven't applied updates before, and you did your planet load 26 days ago, you should supply values that will generate a state.txt that goes back 27 days. You can safely go back further than is required, you'll just re-apply updates. If you have many updates to apply, you should select a day stream then change to minute when you're caught up:
* ```default[:minutely_mapnik][:cfg_txt][:stream]```
  * fetch minute/day/hour diffs for osmosis to process
* ```default[:minutely_mapnik][:cfg_txt][:max_interval]```
  * if you're using a day stream, set this to 86400, otherwise the default is fine
* ```default[:minutely_mapnik][:state_txt][:day]```
  * two digits (currently not validated)
* ```default[:minutely_mapnik][:state_txt][:month]```
  * two digits (currently not validated)
* ```default[:minutely_mapnik][:state_txt][:year]```
  * four digits (currently not validated)

Minute and hour default to '00', which you can override if you so desire. After adjusting all the above, you'll want to set your cron accordingly as well. For example, if you only ever want to apply daily diffs, you should set the cron job to run daily rather than minutely.

You will need to supply the following for database connectivity, if you're using the default update.sh template:
* ```default[:minutely_mapnik][:postgres][:endpoint]```
* ```default[:minutely_mapnik][:postgres][:database]```
* ```default[:minutely_mapnik][:postgres][:username]```
* ```default[:minutely_mapnik][:postgres][:password]```

If you decide to override the default update.sh.erb template, which is the script that cron executes to call osmosis and osm2pgsql in order to apply diffs, you can do so via the following method in your wrapper cookbook:

    include_recipe 'minutely_mapnik'

    # override the default template
    r = resources(template: "#{node[:minutely_mapnik][:basedir]}/bin/update.sh")
    r.cookbook('my_minutely_mapnik_wrapper_cookbook')
    r.source('update.sh.erb') 

Supported Platforms
-------------------
Tested on Ubuntu12.04LTS. You can probably get away with distributions similar to those, but as yet
they have not been tested.

Requirements
------------
* Chef >= 11.10

Attributes
----------
### minutely_mapnik

#### basedir
Default top level directory
* default: /opt/minutely_mapnik

#### user
Default user
* default: mapnik

### minutely_mapnik.cfg_txt

#### stream
Set configuration.txt for minute/hour/day stream
* default: minute

#### max_interval
Number of updates to download in a single invocation of osmosis
* default: 3600 (seconds)

### minutely_mapnik.state_txt

#### minute
Minute to start
* default: 00

#### hour
Hour to start
* default: 00

#### day
Day to start
* default: nil
* since I don't know when your database was installed, I can't guess for you

#### month
Month to start
* default: nil
* since I don't know when your database was installed, I can't guess for you

#### year
Year to start
* default: nil
* since I don't know when your database was installed, I can't guess for you

### minutely_mapnik.cron

#### enable
Should we create a cron job or not
* default: true

#### minute
Minute value for cron job
* default: *

#### hour
Hour value for cron job
* default: *

#### day
Day value for cron job
* default: *

### minutely_mapnik.postgres

#### endpoint
Where's the database?
* default: localhost

#### database
What's the name of the database?
* default: gis

#### username
What username should I connect as in order to process updates?
* default: gis

#### password
What password should i use to connect?
* default: ''

Dependencies
-----------
* osmosis, osm2pgsql

Contributing
------------
Fork, create a feature branch, send a pull! Weeee...

License and Authors
-------------------
License: MIT
Authors: grant@mapzen.com
