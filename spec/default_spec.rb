require 'spec_helper'

describe 'mapzen_minutely_mapnik::default' do
  recipes = %w(
    mapzen_minutely_mapnik::lvm
    mapzen_minutely_mapnik::user
    mapzen_minutely_mapnik::structure
    mapzen_minutely_mapnik::config
    mapzen_minutely_mapnik::deps
    mapzen_minutely_mapnik::sensu
    mapzen_minutely_mapnik::cron
    mapzen_minutely_mapnik::sysctl
    mapzen_minutely_mapnik::logstash
  )

  context 'we are an opsworks node and a member of layer mapnik' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:block_device][:xvdb]
        node.set[:block_device][:xvdc]
        node.set[:mapzen][:environment]         = 'test'
        node.set[:opsworks][:stack][:name]      = 'some::stack'
        node.set[:opsworks][:instance][:layers] = %w(mapnik)
        node.set[:opsworks][:instance][:region] = 'us-east-1'
        node.set[:mapzen][:secrets][:postgresql][:password][:gisuser] = 'blah'
        node.set[:mapzen][:postgresql][:endpoint]                     = 'localhost'
      end.converge(described_recipe)
    end

    recipes.each do |recipe|
      it "should include recipe #{recipe}" do
        stub_command('test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar').and_return(true)
        chef_run.should include_recipe recipe
      end
    end

  end

  context 'we are an opsworks node and not a member of layer mapnik' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:block_device][:xvdb]
        node.set[:block_device][:xvdc]
        node.set[:mapzen][:environment]         = 'test'
        node.set[:opsworks][:stack][:name]      = 'some::stack'
        node.set[:opsworks][:instance][:layers] = %w()
        node.set[:opsworks][:instance][:region] = 'us-east-1'
        node.set[:mapzen][:secrets][:postgresql][:password][:gisuser] = 'blah'
        node.set[:mapzen][:postgresql][:endpoint]                     = 'localhost'
      end.converge(described_recipe)
    end

    recipes.each do |recipe|
      it "should include recipe #{recipe}" do
        stub_command('test -f /opt/logstash/bin/logstash-1.3.3-flatjar.jar').and_return(true)
        chef_run.should_not include_recipe recipe
      end
    end

  end

end
