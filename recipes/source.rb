case node[:platform]
  when 'debian', 'ubuntu'
    include_recipe 'hhvm::_source_debian'

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end
