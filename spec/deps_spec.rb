require 'spec_helper'

describe 'minutely_mapnik::deps' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe osmosis::default' do
    chef_run.should include_recipe 'osmosis::default'
  end

  it 'should include recipe osm2pgsql::default' do
    chef_run.should include_recipe 'osm2pgsql::default'
  end

end
