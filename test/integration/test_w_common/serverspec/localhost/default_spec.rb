require 'spec_helper'

describe 'w_comman::default' do
  describe command("env x='() { :;}; echo vulnerable' bash -c 'echo this is a test'") do
    its(:stdout) { should_not match /vulnerable/ }
  end

	describe package('curl') do
	  it { should be_installed }
	end

  if os[:family] == 'ubuntu' && os[:release] == '12.04'
    describe file('/etc/hostname') do
      it { should exist }
      its(:content) { should match /^test-w-common-ubuntu-1204$/ }
    end

    describe file('/etc/hosts') do
      it { should exist }
      it { should contain 'test-w-common-ubuntu-1204.examplewebsite.com' }
    end
  end

  if os[:family] == 'ubuntu' && os[:release] == '14.04'
    describe file('/etc/hostname') do
      it { should exist }
      its(:content) { should match /^test-w-common-ubuntu-1404$/ }
    end

    describe file('/etc/hosts') do
      it { should exist }
      it { should contain 'test-w-common-ubuntu-1404.examplewebsite.com' }
    end
  end

  # timezone should be est or edt
  describe command('date +%Z') do
    its(:stdout) { should match(/(EST|EDT)/) }
  end

  describe port(22) do
  	it { should be_listening.with('tcp') }
	end

end