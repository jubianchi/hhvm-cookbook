include_recipe 'apt'

case node['platform_version'].to_i
  when 7
    release = 'wheezy'

  when 12.04
    release = 'precise'

  when 13.1
    release = 'saucy'

  else
    raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end

apt_repository "mapnik-boost" do
  uri "http://ppa.launchpad.net/mapnik/boost/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "5D50B6BA"
  action :add
end if node['lsb']['codename'] == 'precise'

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
