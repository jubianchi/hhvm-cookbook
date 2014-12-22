case node['platform']
  when 'debian', 'ubuntu'
    unless defined? node['hhvm']['source']['dependencies'][node['platform']][node['platform_version'].to_f]
      raise %W(Platform not supported: #{node['platform_family']} (#{node['platform']}) #{node['platform_version']}).join(' ')
    end

    node['hhvm']['source']['dependencies'][node['platform']][node['platform_version'].to_f].each do |pkg|
      package pkg
    end

    include_recipe 'hhvm::_source_'.concat(node[:platform])

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end
