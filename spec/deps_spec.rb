require 'spec_helper'

describe 'mapzen_minutely_mapnik::deps' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:mapzen][:environment]         = 'test'
      node.set[:opsworks][:stack][:name]      = 'some::stack'
      node.set[:opsworks][:instance][:layers] = %w(mapnik)
      node.set[:opsworks][:instance][:region] = 'us-east-1'
      node.set[:mapzen][:secrets][:postgresql][:password][:gisuser] = 'blah'
      node.set[:mapzen][:postgresql][:endpoint]                     = 'localhost'
    end.converge(described_recipe)
  end

  it 'should add apt repository apt.postgresql.org' do
    chef_run.should add_apt_repository('apt.postgresql.org').with(
      uri:          'http://apt.postgresql.org/pub/repos/apt',
      distribution: 'precise-pgdg',
      components:   ['main'],
      key:          'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
    )
  end

  %w(
    pgdg-keyring
    postgresql-client-9.3
    postgresql-9.3-postgis-2.1
  ).each do |pkg|
    it "should install package #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it 'should stop and disable postgresql' do
    chef_run.should stop_service 'postgresql'
    chef_run.should disable_service 'postgresql'
  end

  it 'should include recipe osmosis::default' do
    chef_run.should include_recipe 'osmosis::default'
  end

  it 'should include recipe osm2pgsql::default' do
    chef_run.should include_recipe 'osm2pgsql::default'
  end

end
