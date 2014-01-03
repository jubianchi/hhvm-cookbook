default['hhvm']['installation_type'] = 'package'

# Package installation
default['hhvm']['enable_fastcgi'] = true

# Source installation
default['hhvm']['source']['revision'] = 'master'
default['hhvm']['source']['libevent_revision'] = 'release-1.4.14b-stable'
default['hhvm']['source']['dependencies']['debian'][12.04] = [
    'git-core', 'cmake', 'g++', 'libboost1.48-dev', 'libmysqlclient-dev', 'libxml2-dev', 'libmcrypt-dev',
    'libicu-dev', 'openssl', 'build-essential', 'binutils-dev', 'libcap-dev', 'libgd2-xpm-dev', 'zlib1g-dev',
    'libtbb-dev', 'libonig-dev', 'libpcre3-dev', 'autoconf', 'libtool', 'libcurl4-openssl-dev',
    'libboost-regex1.48-dev', 'libboost-system1.48-dev', 'libboost-program-options1.48-dev',
    'libboost-filesystem1.48-dev', 'libboost-thread1.48-dev', 'wget', 'memcached', 'libreadline-dev', 'libncurses-dev',
    'libmemcached-dev', 'libbz2-dev', 'libc-client2007e-dev', 'php5-mcrypt', 'php5-imagick', 'libgoogle-perftools-dev',
    'libcloog-ppl0', 'libelf-dev', 'libdwarf-dev', 'subversion', 'python-software-properties'
]
default['hhvm']['source']['dependencies']['debian'][13.1] = [
    'autoconf', 'automake', 'binutils-dev', 'build-essential', 'cmake', 'g++', 'git', 'libboost-dev',
    'libboost-filesystem-dev', 'libboost-program-options-dev', 'libboost-regex-dev', 'libboost-system-dev',
    'libboost-thread-dev', 'libbz2-dev', 'libc-client-dev', 'libc-client2007e-dev', 'libcap-dev',
    'libcurl4-openssl-dev', 'libdwarf-dev', 'libelf-dev', 'libexpat-dev', 'libgd2-xpm-dev', 'libgoogle-glog-dev',
    'libgoogle-perftools-dev', 'libicu-dev', 'libjemalloc-dev', 'libmcrypt-dev', 'libmemcached-dev',
    'libmysqlclient-dev', 'libncurses-dev', 'libonig-dev', 'libpcre3-dev', 'libreadline-dev', 'libtbb-dev', 'libtool',
    'libxml2-dev', 'zlib1g-dev'
]

default['hhvm']['source']['layout']['working_dir'] = '/usr/src'
default['hhvm']['source']['layout']['prefix'] = '/usr'