#
# Cookbook Name:: w_common
# Spec:: network
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


require 'spec_helper'

describe 'w_common::network' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|

      end.converge(described_recipe)
    end

    it 'includes sysctl::default recipe' do
      expect(chef_run).to include_recipe('sysctl')
    end

    it 'enables arp_filter' do
      expect(chef_run).to apply_sysctl_param('net.ipv4.conf.all.arp_filter').with_value(1)
    end
  end
end
