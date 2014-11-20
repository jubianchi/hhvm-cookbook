default['hhvm']['installation_type'] = 'package'

# Package installation
default['hhvm']['package']['type'] = :default

# If true, this cookbook will deploy a new repository (hop5.in) to install the 'hhvm' package.
# Set to false if you already have 'hhvm' and all dependencies available on your own repository.
default['hhvm']['setup_centos_epel_repo'] = true

# If true, this cookbook will deploy epel before installing the 'hhvm' package.
default['hhvm']['setup_centos_hhvm_repo'] = true

# Source installation
default['hhvm']['source']['hhvm_repository'] = 'git://github.com/facebook/hhvm.git'
default['hhvm']['source']['hhvm_revision'] = 'master'
default['hhvm']['source']['libevent_repository'] = 'git://github.com/libevent/libevent.git'
default['hhvm']['source']['libevent_revision'] = 'eb8122f26c278e6e3e8a495618ed1ccad293e717' #release-1.4.14b-stable

default['hhvm']['source']['make_jobs'] = 1

default['hhvm']['source']['dependencies']['ubuntu'][12.04] = [
  'git-core', 'cmake', 'g++', 'libboost1.48-dev', 'libmysqlclient-dev', 'libxml2-dev', 'libmcrypt-dev',
  'libicu-dev', 'openssl', 'build-essential', 'binutils-dev', 'libcap-dev', 'libgd2-xpm-dev', 'zlib1g-dev',
  'libtbb-dev', 'libonig-dev', 'libpcre3-dev', 'autoconf', 'libtool', 'libcurl4-openssl-dev',
  'libboost-regex1.48-dev', 'libboost-system1.48-dev', 'libboost-program-options1.48-dev',
  'libboost-filesystem1.48-dev', 'libboost-thread1.48-dev', 'wget', 'memcached', 'libreadline-dev', 'libncurses-dev',
  'libmemcached-dev', 'libbz2-dev', 'libc-client2007e-dev', 'php5-mcrypt', 'php5-imagick', 'libgoogle-perftools-dev',
  'libcloog-ppl0', 'libelf-dev', 'libdwarf-dev', 'subversion', 'python-software-properties'
]
default['hhvm']['source']['dependencies']['ubuntu'][13.1] = [
  'autoconf', 'automake', 'binutils-dev', 'build-essential', 'cmake', 'g++', 'git', 'libboost-dev',
  'libboost-filesystem-dev', 'libboost-program-options-dev', 'libboost-regex-dev', 'libboost-system-dev',
  'libboost-thread-dev', 'libbz2-dev', 'libc-client-dev', 'libc-client2007e-dev', 'libcap-dev',
  'libcurl4-openssl-dev', 'libdwarf-dev', 'libelf-dev', 'libexpat-dev', 'libgd2-xpm-dev', 'libgoogle-glog-dev',
  'libgoogle-perftools-dev', 'libicu-dev', 'libjemalloc-dev', 'libmcrypt-dev', 'libmemcached-dev',
  'libmysqlclient-dev', 'libncurses-dev', 'libonig-dev', 'libpcre3-dev', 'libreadline-dev', 'libtbb-dev', 'libtool',
  'libxml2-dev', 'zlib1g-dev'
]
default['hhvm']['source']['dependencies']['ubuntu'][14.04] = [
  'autoconf', 'automake', 'binutils-dev', 'build-essential', 'cmake', 'g++', 'git', 'libboost-dev',
  'libboost-filesystem-dev', 'libboost-program-options-dev', 'libboost-regex-dev', 'libboost-system-dev',
  'libboost-thread-dev', 'libbz2-dev', 'libc-client-dev', 'libldap2-dev', 'libc-client2007e-dev',
  'libcap-dev', 'libcurl4-openssl-dev', 'libdwarf-dev', 'libelf-dev', 'libexpat-dev', 'libgd2-xpm-dev',
  'libgoogle-glog-dev', 'libgoogle-perftools-dev', 'libicu-dev', 'libjemalloc-dev', 'libmcrypt-dev',
  'libmemcached-dev', 'libmysqlclient-dev', 'libncurses-dev', 'libonig-dev', 'libpcre3-dev', 'libreadline-dev',
  'libtbb-dev', 'libtool', 'libxml2-dev', 'zlib1g-dev', 'libevent-dev', 'libmagickwand-dev', 'libinotifytools0-dev',
  'libiconv-hook-dev', 'libedit-dev', 'libiberty-dev', 'libxslt1-dev', 'ocaml-native-compilers', 'php5-imagick'
]

default['hhvm']['source']['dependencies']['debian'][7.0] =
default['hhvm']['source']['dependencies']['debian'][7.1] =
default['hhvm']['source']['dependencies']['debian'][7.2] =
default['hhvm']['source']['dependencies']['debian'][7.3] =
default['hhvm']['source']['dependencies']['debian'][7.4] = [
  'git-core', 'cmake', 'libmysqlclient-dev', 'libxml2-dev', 'libmcrypt-dev', 'libicu-dev', 'openssl', 'build-essential',
  'binutils-dev', 'libcap-dev', 'zlib1g-dev', 'libtbb-dev', 'libonig-dev', 'libpcre3-dev', 'autoconf', 'libtool',
  'libcurl4-openssl-dev', 'wget', 'memcached', 'libreadline-dev', 'libncurses-dev', 'libmemcached-dev', 'libbz2-dev',
  'libc-client2007e-dev', 'php5-mcrypt', 'php5-imagick', 'libgoogle-perftools-dev', 'libcloog-ppl0', 'libelf-dev',
  'libdwarf-dev', 'libunwind7-dev', 'subversion', 'libtbb2', 'libtbb-dev', 'g++-4.7', 'gcc-4.7', 'libjemalloc-dev',
  'libc6-dev', 'libmpfr4', 'libgcc1', 'binutils', 'libc6', 'libc-dev-bin', 'libc-bin', 'libgomp1', 'libstdc++6-4.7-dev',
  'libstdc++6', 'cmake', 'libarchive12', 'cmake-data', 'libacl1', 'libattr1', 'g++', 'cpp', 'gcc', 'make',
  'libboost-thread1.49.0', 'libboost-thread-dev', 'libgd2-xpm-dev', 'pkg-config', 'libdwarf-dev', 'binutils-dev',
  'libboost-system1.49-dev', 'libboost-program-options1.49-dev', 'libboost-filesystem1.49-dev', 'libboost-regex1.49-dev'
]

default['hhvm']['source']['layout']['working_dir'] = '/usr/src'
default['hhvm']['source']['layout']['prefix'] = '/usr'
