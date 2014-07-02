require 'spec_helper'

describe 'minutely_mapnik::deps' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe osmosis::default' do
    expect(chef_run).to include_recipe 'osmosis::default'
  end

  it 'should include recipe osm2pgsql::default' do
    expect(chef_run).to include_recipe 'osm2pgsql::default'
  end

end
