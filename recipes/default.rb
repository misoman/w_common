include_recipe 'w_common::network'

# php-dev, percona related packages and some other package needs latest updated packages
include_recipe 'apt'

# doc start handle bash vulnerability http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-6271
package 'bash' do
  action :upgrade
end

package 'curl'
package 'telnet'

include_recipe 'sudo'
include_recipe 'hostname'
include_recipe 'w_common::users' if node['w_common']['set_users']
# user recipe needs to be executed before ntp because ntp create group ntp with gid 111
include_recipe 'ntp'
include_recipe 'timezone-ii'
include_recipe 'w_common::newrelic_server' if node['w_common']['newrelic_server_enabled']
include_recipe 'w_common::hosts' if node['w_common']['ha_connecction']

include_recipe 'firewall'

if node['monit_enabled'] then
  firewall_rule 'monit httpd' do
    port  2812
  end
end
