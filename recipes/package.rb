case node[:platform]
  when 'debian', 'ubuntu'
    include_recipe 'hhvm::_package_debian'

  when 'rhel', 'centos'
    include_recipe 'hhvm::_package_rhel'

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end
