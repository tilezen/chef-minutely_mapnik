require 'spec_helper'

describe 'minutely_mapnik::cron' do
  context 'cron is enabled' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:minutely_mapnik][:cron][:enable] = true
      end.converge(described_recipe)
    end

    it 'should create the cron job: minutely mapnik ' do
      expect(chef_run).to create_cron('minutely mapnik').with(
        user:     'mapnik',
        command:  '/opt/minutely_mapnik/bin/update.sh >/opt/minutely_mapnik/logs/update.out 2>&1'
      )
    end
  end

  context 'cron is disabled' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:minutely_mapnik][:cron][:enable] = false
      end.converge(described_recipe)
    end

    it 'should not try to create the cron job: minutely mapnik ' do
      expect(chef_run).to_not create_cron 'minutely mapnik'
    end
  end

end
