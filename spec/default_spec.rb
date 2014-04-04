require 'spec_helper'

describe 'minutely_mapnik::default' do
  recipes = %w(
    minutely_mapnik::structure
    minutely_mapnik::user
    minutely_mapnik::config
    minutely_mapnik::deps
    minutely_mapnik::cron
  )

  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  recipes.each do |recipe|
    it "should include recipe #{recipe}" do
      chef_run.should include_recipe recipe
    end
  end

end
