case node[:platform_family]
  when 'debian'
    include_recipe 'hhvm::_package_debian'

  when 'rhel'
    include_recipe 'hhvm::_package_rhel'

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end
include_recipe 'hhvm::_config'