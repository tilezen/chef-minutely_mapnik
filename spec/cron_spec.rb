require 'spec_helper'

describe 'mapzen_minutely_mapnik::cron' do
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

  it 'should create the cron job mapzen_minutely_mapnik' do
    chef_run.should create_cron('mapzen_minutely_mapnik').with(
      minute:   '*',
      hour:     '*',
      day:      '*',
      user:     'mapnik',
      command:  '/opt/minutely_mapnik/bin/update.sh >/opt/minutely_mapnik/logs/update.out 2>&1'
    )
  end

end
