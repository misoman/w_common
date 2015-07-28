name             'w_common'
maintainer       'Joel Handwell'
maintainer_email 'joelhandwell@gmail.com'
license          'apachev2'
description      'Installs/Configures common components among all virtual machines'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.15'

depends 'apt'
depends 'sudo'
depends 'ntp'
depends 'timezone-ii'
depends 'firewall'
depends 'hostsfile'
