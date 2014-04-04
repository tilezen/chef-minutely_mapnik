require 'spec_helper'

describe 'mapzen_minutely_mapnik::config' do
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

  it 'should install package python-pip' do
    chef_run.should install_package 'python-pip'
  end

  it 'should execute pip install awscli' do
    chef_run.should run_execute 'pip install awscli'
  end

  it 'should create template /opt/minutely_mapnik/bin/update.sh' do
    chef_run.should create_template('/opt/minutely_mapnik/bin/update.sh').with(
      owner:  'mapnik',
      group:  'mapnik',
      source: 'update.sh.erb',
      mode:   0755
    )
  end

  it 'should create template /opt/minutely_mapnik/osmosis/configuration.txt' do
    chef_run.should create_cookbook_file('/opt/minutely_mapnik/osmosis/configuration.txt').with(
      owner:  'mapnik',
      group:  'mapnik',
      source: 'configuration.txt',
      mode:   0644
    )
  end

  it 'should create template /etc/logrotate.d/mapnik' do
    chef_run.should create_template('/etc/logrotate.d/mapnik').with(
      owner:  'root',
      group:  'root',
      source: 'mapnik-logrotate.erb',
      mode:   0644
    )
  end

end
