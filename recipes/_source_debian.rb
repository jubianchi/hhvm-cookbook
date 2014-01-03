include_recipe 'apt'

unless defined? node['hhvm']['source']['dependencies']['debian'][node['platform_version'].to_f]
  raise %W(Platform not supported: #{node['platform_family']} (#{node[:platform]}) #{node['platform_version']}).join(' ')
end

node['hhvm']['source']['dependencies']['debian'][node['platform_version'].to_f].each do |pkg|
  log 'install-'.concat(pkg) do
    message 'Installing '.concat(pkg)
    level :info
  end

  package pkg do
    action :install
  end
end

git 'hhvm' do
  repository 'git://github.com/facebook/hhvm.git'
  reference node['hhvm']['source']['revision']
  destination File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
  enable_submodules true
  depth 50
  action :sync
  notifies :sync, 'git[libevent]', :immediately
end

git 'libevent' do
  repository 'git://github.com/libevent/libevent.git'
  reference node['hhvm']['source']['libevent_revision']
  destination File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')
  action :nothing
  notifies :run, 'execute[libevent-patch]', :immediately
end

execute 'libevent-patch' do
  patch = File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm', 'hphp', 'third_party', 'libevent-1.4.14.fb-changes.diff')

  command "cat #{patch} | patch -p1"
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')
  action :nothing
  notifies :run, 'execute[libevent-autogen]', :immediately
end

execute 'libevent-autogen' do
  command './autogen.sh'
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')
  action :nothing
  notifies :run, 'execute[libevent-configure]', :immediately
end

execute 'libevent-configure' do
  command './configure --prefix='.concat(node['hhvm']['source']['layout']['prefix'])
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')
  action :nothing
  notifies :run, 'execute[libevent-make]', :immediately
end

execute 'libevent-make' do
  command 'make -j2 && make install'
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')
  action :nothing
  notifies :run, 'execute[hhvm-cmake]', :immediately
end

execute 'hhvm-cmake' do
  command 'cmake .'
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
  environment ({
    'CMAKE_PREFIX_PATH' => node['hhvm']['source']['layout']['prefix'],
    'HPHP_HOME' => File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
  })
  action :nothing
  notifies :run, 'execute[hhvm-make]', :immediately
end

execute 'hhvm-make' do
  command 'make -j2'
  cwd File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
  environment ({
    'CMAKE_PREFIX_PATH' => node['hhvm']['source']['layout']['prefix'],
    'HPHP_HOME' => File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
  })
  action :nothing
end
