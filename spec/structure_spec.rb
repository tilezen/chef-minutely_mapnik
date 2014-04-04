require 'spec_helper'

describe 'mapzen_minutely_mapnik::structure' do
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

  it 'should create the base directory' do
    chef_run.should create_directory('/opt/minutely_mapnik').with(
      owner: 'mapnik',
      group: 'mapnik',
      mode:  0755
    )
  end

  %w(bin logs osmosis).each do |dir|
    it "should create directory #{dir}" do
      chef_run.should create_directory("/opt/minutely_mapnik/#{dir}").with(
        owner: 'mapnik',
        group: 'mapnik',
        mode:  0755
      )
    end
  end

end
