include_recipe 'yum'

if node['hhvm']['setup_centos_epel_repo']
  case node['platform_version'].to_f
    when 6.4, 6.5, 6.6, 6.7 
      remote_file '/tmp/epel.rpm' do
        source 'http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm'
        action :create_if_missing
      end

      package 'epel' do
        source '/tmp/epel.rpm'
        provider Chef::Provider::Package::Rpm
        action :install
      end
    else
      raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
  end
end

if node['hhvm']['setup_centos_hhvm_repo']
  yum_repository 'hhvm' do
    baseurl 'http://www.hop5.in/yum/el6/'
    gpgkey 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-HOP5'
    action :create
    notifies :run, 'bash[yum-clean-all]', :immediately
  end
end

bash 'yum-clean-all' do
  command 'yum clean all'
  action :nothing
end

package 'hhvm' do
  options '-y --nogpgcheck'
end

if node['hhvm']['enable_fastcgi']
  log 'hhvm-fastcgi not supported' do
    message %W(hhvm-fastcgi is not supported on #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
    level :warn
  end
end
