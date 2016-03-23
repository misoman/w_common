# commom operation among all chef roles
hostsfile_entry '127.0.0.1' do
  hostname 'localhost'
  action :append
  unique true
end

hostsfile_entry node['chefserver']['ip'] do
  hostname node['chefserver']['hostname']
  action :append
  unique true
end

if node['dbhosts']['webapp_ip'].instance_of?(Chef::Node::ImmutableArray) then
  webapp_ips = node['dbhosts']['webapp_ip']
else
  webapp_ips = []
  webapp_ips << node['dbhosts']['webapp_ip']
end

if node['dbhosts']['db_ip'].instance_of?(Chef::Node::ImmutableArray) then
  db_ips = node['dbhosts']['db_ip']
else
  db_ips = []
  db_ips << node['dbhosts']['db_ip']
end

node['w_common']['web_apps'].each do |web_app|
  next unless web_app.has_key?('connection_domain')
  webapp_ips.each_with_index do |webapp_ip, index|
    hostsfile_entry "#{webapp_ip} for #{web_app['vhost']['main_domain']}" do
      ip_address webapp_ip
      hostname "#{index}#{web_app['connection_domain']['webapp_domain']}"
      action :append
      unique true
    end
  end

  next unless web_app['connection_domain'].has_key?('db_domain')
  db_ips.each_with_index do |db_ip, index|
    hostsfile_entry "#{db_ip} for #{web_app['vhost']['main_domain']}" do
      ip_address db_ip
      hostname "#{index}#{web_app['connection_domain']['db_domain']}"
      action :append
      unique true
    end
  end
end
