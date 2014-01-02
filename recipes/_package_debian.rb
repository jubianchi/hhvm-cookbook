include_recipe 'apt'

case node['platform_version'].to_f
  when 7
    release = 'wheezy'

  when 12.04
    release = 'precise'

  when 13.1
    release = 'saucy'

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end

apt_repository 'hhvm' do
  uri          'http://dl.hhvm.com/'.concat(node[:platform])
  distribution release
  components   ['main']
  key          'http://dl.hhvm.com/conf/hhvm.gpg.key'
end

package 'hhvm'

if node['hhvm']['enable_fastcgi']
  package 'hhvm-fastcgi'
end
