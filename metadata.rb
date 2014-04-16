name                   'hhvm'
maintainer             'jubianchi'
maintainer_email       'contact@jubianchi.fr'
license                'MIT'
description            'Installs/Configures hhvm'
long_description       IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version                '0.3.1'

depends                'apt'
depends                'yum'

supports               'debian'
supports               'ubuntu'
supports               'centos'

recipe 'hhvm',         'Installs hhvm'
recipe 'php::package', 'Installs hhvm using packages.'
recipe 'php::source',  'Installs hhvm from source.'
