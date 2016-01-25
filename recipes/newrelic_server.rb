newrelic_server_monitor 'install' do
  license data_bag_item('newrelic', 'newrelic_license')['newrelic_license_key']
  hostname node.name
  service_actions node['w_common']['newrelic_server_actions']
end