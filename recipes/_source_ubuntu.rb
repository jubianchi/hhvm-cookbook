if node[:platform_version] == '12.04'
    apt_repository 'gcc47' do
      uri 'http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu'
      distribution node['lsb']['codename']
      components ['main']
    end

    package 'gcc-4.7'
    package 'g++-4.7'

    execute 'update-alternatives-g47' do
        command 'update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.7'
    end

    execute 'update-alternatives-g46' do
        command 'update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6'
    end

    execute 'update-alternatives-gcc47' do
        command 'update-alternatives --set gcc /usr/bin/gcc-4.7'
    end

    include_recipe 'hhvm::_source_common_glog'
end

include_recipe 'hhvm::_source_common_hhvm'
