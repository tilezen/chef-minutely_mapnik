require 'spec_helper'

describe 'minutely_mapnik::structure' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should create the base directory' do
    chef_run.should create_directory('/opt/minutely_mapnik').with(
      owner: 'mapnik',
      group: 'mapnik',
      mode:  0755
    )
  end

  %w(bin logs osmosis).each do |d|
    it "should create directory #{d}" do
      chef_run.should create_directory("/opt/minutely_mapnik/#{d}").with(
        owner: 'mapnik',
        group: 'mapnik',
        mode:  0755
      )
    end
  end

end
