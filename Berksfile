# -*- mode: ruby -*-
# vi: set ft=ruby :
source 'https://supermarket.chef.io'

cookbook 'ubuntu'
cookbook 'apt'
cookbook 'apt-repo', git: 'https://github.com/sometimesfood/chef-apt-repo.git'
cookbook 'git'
cookbook 'monit', git: 'https://github.com/phlipper/chef-monit.git'
cookbook 'firewall', git: 'https://github.com/opscode-cookbooks/firewall.git', ref: '3c4832f3498141287981a8687855531b0d746fc9'
cookbook 'ntp'
cookbook 'sudo'
cookbook 'timezone-ii'
cookbook 'windows', git: 'https://github.com/opscode-cookbooks/windows.git', ref: '0dae7405020b1521b61170267fdeedc022c3a448'
cookbook 'hostname'

group :wrapper do
  cookbook 'w_common', path: './'
end
