require 'spec_helper'

describe 'w_common::newrelic_server' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['w_common']['web_apps'] = web_apps
      node.set['w_common']['newrelic_server_enabled'] = true
    end.converge(described_recipe)
  end

  before do
    stub_data_bag_item("newrelic", "newrelic_license").and_return('newrelic_license_key' => 'xxxxxxxxxxxxxxxxxxxx')
  end

  it 'installs newrelic app monitoring' do
    expect(chef_run).to install_newrelic_server_monitor('install').with(
        license: 'xxxxxxxxxxxxxxxxxxxx',
        service_actions: ['enable', 'start']
      )
  end

end