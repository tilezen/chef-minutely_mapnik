require 'spec_helper'

describe 'minutely_mapnik::config' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should create template /opt/minutely_mapnik/bin/update.sh' do
    expect(chef_run).to create_template('/opt/minutely_mapnik/bin/update.sh').with(
      owner:  'mapnik',
      group:  'mapnik',
      source: 'update.sh.erb',
      mode:   0755
    )
  end

  it 'should create template /opt/minutely_mapnik/osmosis/configuration.txt' do
    expect(chef_run).to create_template('/opt/minutely_mapnik/osmosis/configuration.txt').with(
      owner:  'mapnik',
      group:  'mapnik',
      source: 'configuration.txt.erb',
      mode:   0644
    )
  end

  it 'should create template /etc/logrotate.d/mapnik' do
    expect(chef_run).to create_template('/etc/logrotate.d/mapnik').with(
      owner:  'root',
      group:  'root',
      source: 'mapnik-logrotate.erb',
      mode:   0644
    )
  end

  it 'should create remote_file state.txt' do
    expect(chef_run).to create_remote_file('/opt/minutely_mapnik/osmosis/state.txt').with(
      owner:  'mapnik',
      group:  'mapnik',
      mode:   0644
    )
  end

end
