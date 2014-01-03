case node['hhvm']['installation_type']
  when 'source'
    include_recipe 'hhvm::source'

  when 'package'
    include_recipe 'hhvm::package'

  else
    raise 'Invalid installation type: '.concat(node['hhvm']['installation_type'])
end
