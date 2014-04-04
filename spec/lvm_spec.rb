require 'spec_helper'

describe 'mapzen_minutely_mapnik::lvm' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:mapzen][:environment]           = 'test'
      node.set[:opsworks][:stack][:name]        = 'some::stack'
      node.set[:opsworks][:instance][:layers]   = %w(mapnik)
      node.set[:opsworks][:instance][:region]   = 'us-east-1'
      node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
      node.set[:mapzen][:postgresql][:endpoint] = 'localhost'
      node.set[:block_device][:xvdb]            = true
      node.set[:block_device][:xvdc]            = true
    end.converge(described_recipe)
  end

  it 'should include recipe lvm::default' do
    chef_run.should include_recipe 'lvm::default'
  end

end
