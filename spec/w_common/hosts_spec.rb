require_relative '../spec_helper'

describe 'w_common::hosts' do

  context 'default configuration' do

    let(:run_list_items){
      Chef::RunList.new('role[w_mysql_role]')
    }

    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['w_common']['web_apps'] = web_apps
        node.set['dbhosts'] = {
          "db_ip" => ["2.2.2.2"],
          "webapp_ip" => ["1.1.1.1"]
        }

        node.set['chefserver'] = {
          "hostname" => "chefserver.example.com",
          "ip" => "0.0.0.0"
        }

        allow(node).to receive(:role?).with('w_apache_role').and_return(false)
        allow(node).to receive(:role?).with('w_mysql_role').and_return(true)
        allow(node).to receive(:role?).with('w_percona_role').and_return(false)
      end.converge(described_recipe)
    end


    it 'generates /etc/hosts file entry for default localhost' do
      expect(chef_run).to append_hostsfile_entry('127.0.0.1').with_hostname('localhost').with(unique: true)
    end

    it 'generates /etc/hosts file entry to enable communication btw chef node and chefserver' do
      expect(chef_run).to append_hostsfile_entry('0.0.0.0').with_hostname('chefserver.example.com').with_unique(true)
    end

    it 'generates /etc/hosts file entries to enable communication btw apache and db' do
      expect(chef_run).to append_hostsfile_entry('1.1.1.1 for example.com').with_hostname('0webapp.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('2.2.2.2 for example.com').with_hostname('0db.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('1.1.1.1 for example2.com').with_hostname('0webapp.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('2.2.2.2 for example2.com').with_hostname('0db.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('1.1.1.1 for example3.com').with_hostname('0webapp.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('2.2.2.2 for example3.com').with_hostname('0db.example.com').with_unique(true)
      expect(chef_run).to append_hostsfile_entry('127.0.0.1').with_hostname('localhost').with_unique(true)
    end
  end
end
