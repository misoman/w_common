require 'chefspec'
require 'chefspec/berkshelf'
require 'mymatchers'
require 'coveralls'
Coveralls.wear!

ChefSpec::Coverage.start! do
  add_filter(%r{[\/\\]ntp[\/\\]})
  add_filter(%r{[\/\\]sudo[\/\\]})
  add_filter(%r{[\/\\]timezone-ii[\/\\]})
  add_filter(%r{[\/\\]apt[\/\\]})
  add_filter(%r{[\/\\]monit[\/\\]})
  add_filter(%r{[\/\\]build-essential[\/\\]})
  add_filter(%r{[\/\\]git[\/\\]})
  add_filter(%r{[\/\\]hostname[\/\\]})
  add_filter(%r{[\/\\]firewall[\/\\]})
  add_filter(%r{[\/\\]chef-sugar[\/\\]})
  add_filter(%r{[\/\\]newrelic[\/\\]})
  add_filter(%r{[\/\\]sysctl[\/\\]})
 end

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
  config.log_level = :error
end

def web_apps
  [
    { vhost: { main_domain: 'example.com', aliases: ['www.example.com', 'ex.com'], docroot: '/websites/example.com/www'  } , deploy: { repo_ip: '9.9.9.9', repo_domain: 'git.examplewebsite.com', repo_path: '/websites/example.com', repo_url: 'https://git.examplewebsite.com/www.git' }   , connection_domain: { webapp_domain: 'webapp.example.com', db_domain: 'db.example.com', varnish_domain: 'varnish.example.com' }, mysql: [ { db: 'db',                  user: 'user', password: 'password' }], varnish: { purge_target: true }  },
    { vhost: { main_domain: 'example2.com',                                        docroot: '/websites/example2.com/sub' } , deploy: { repo_ip: '9.9.9.9', repo_domain: 'git.examplewebsite.com', repo_path: '/websites/example2.com', repo_url: 'https://git.examplewebsite.com/www2.git' } , connection_domain: { webapp_domain: 'webapp.example.com', db_domain: 'db.example.com'                                        }, mysql: [ { db: ['db2', 'db3', 'db4'], user: 'user', password: 'password' }]                                   },
    { vhost: { main_domain: 'example3.com',                                        docroot: '/websites/example3.com/sub' }                                                                                                                                                                   , connection_domain: { webapp_domain: 'webapp.example.com', db_domain: 'db.example.com'                                        }, mysql: [ { db: ['db2', 'db3', 'db4'], user: 'user', password: 'password' }]                                   },
    { vhost: { main_domain: 'apache_and_varnish_only.com',             docroot: '/websites/apache_and_varnish_only.com'  }                                                                                                                                                                   , connection_domain: { webapp_domain: 'webapp.apache_and_varnish_only.com',              varnish_domain: 'varnish.apache_and_varnish_only.com' },                                                              varnish: { purge_target: true }  },
    { vhost: { main_domain: 'docroot-only-vhost.com',                              docroot: '/websites/dov'              }},
    { vhost: { main_domain: 'docroot-create-disable.com',                          docroot: '/websites/dcd',                 create_docroot_dir: false }},
    { vhost: { main_domain: 'multi-repo-vhost.com',                                docroot: '/websites/multi-repo-vhost' } , deploy: [{ repo_path: '/websites/multi-repo-vhost.com', repo_url: 'https://git.examplewebsite.com/multi-repo-vhost.com-repo1.git' }, { repo_path: '/websites/multi-repo-vhost.com/repo2', repo_url: 'https://git.examplewebsite.com/multi-repo-vhost.com-repo2.git' }]  },
    { vhost: { main_domain: 'ssl.example.com', aliases: ['ssl2.example.com'], ssl: true, docroot: '/websites/example.com/ssl' }},
    { vhost: { main_domain: 'ssl-disabled.example.com', ssl: false, docroot: '/websites/example.com/ssl_disabled' }},
    { vhost: { main_domain: 'ssl-without-intermediate-cert.com',              ssl: true, docroot: '/websites/ssl-website-wic.com' }}
  ]
end
