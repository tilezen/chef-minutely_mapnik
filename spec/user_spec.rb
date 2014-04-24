require 'spec_helper'

describe 'minutely_mapnik::user' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should create the user mapnik' do
    chef_run.should create_user_account('mapnik').with(
      shell:        '/bin/bash',
      ssh_keygen:   false,
      manage_home:  true,
      create_group: true
    )
  end

end
