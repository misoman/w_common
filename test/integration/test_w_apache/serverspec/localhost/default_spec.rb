require 'spec_helper'

describe 'w_apache::default' do

	['ondrej/php5', 'ondrej/apache2'].each do |ppa| 
		describe ppa("#{ppa}") do
		  it { should exist }
		  it { should be_enabled }
		end
	end
	
	['apache2', 'apache2-mpm-worker'].each do |package|	
		describe package("#{package}") do
	  	it { should be_installed }
		end
	end
	
	describe service('apache2') do
		it { should be_enabled }
		it { should be_running }
	end

	describe port(80) do
	  it { should be_listening.with('tcp') }
	end

end