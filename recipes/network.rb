#
# Cookbook Name:: common
# Recipe:: network
#
# Copyright 2016 Joel Handwell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# enabling arp_filter will address https://github.com/haapp/w_percona/issues/30
# reference:
# http://serverfault.com/questions/203436/ubuntu-server-ssh-write-failed-broken-pipe
# http://serverfault.com/questions/207480/massive-packet-loss-when-servers-are-brought-online

include_recipe 'sysctl'

if node['network']['enable_arp_filter'] then
  sysctl_param 'net.ipv4.conf.all.arp_filter' do
    value 1
  end
end
