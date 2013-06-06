require 'spec_helper'

describe 'puppetdb::server', :type => :class do

  let(:facts) do
    {
      :osfamily                 => 'RedHat',
      :fqdn                     => 'test.domain.local',
      :postgres_default_version => 1
    }
  end

  context 'with defaults' do
    let :params do
      {}
    end
  end

  context 'when configuring ssl certs' do
    let :params do
      {:setup_ssl_certs => true}
    end
    it { should contain_exec('puppetdb-ssl-setup').with(
      :path    => ['/usr/sbin/', '/usr/bin', '/bin'],
      :creates => '/etc/puppetdb/ssl/',
      :require => 'Class[Puppetdb::Server::Jetty_ini]',
      :notify  => 'Service[puppetdb]'
    ) }
  end

end
