name                   'hhvm'
maintainer             'jubianchi'
maintainer_email       'contact@jubianchi.fr'
license                'MIT'
description            'Installs/Configures hhvm'
long_description       IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version                '0.5.1'

depends                'apt'
depends                'yum'

supports               'debian'
supports               'ubuntu'
supports               'centos'

recipe 'hhvm',          'Installs hhvm'
recipe 'hhvm::package', 'Installs hhvm using packages.'
recipe 'hhvm::source',  'Installs hhvm from source.'
