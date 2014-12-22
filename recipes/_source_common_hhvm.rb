hhvm_src = File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm')
env = {
    'CMAKE_PREFIX_PATH' => node['hhvm']['source']['layout']['prefix'],
    'HPHP_HOME' => hhvm_src
}

git 'hhvm' do
  repository node['hhvm']['source']['hhvm_repository']
  reference node['hhvm']['source']['hhvm_revision']
  destination hhvm_src
  enable_submodules true
  depth 50
  action :sync
  if node['platform'] == "Ubuntu" and node['platform_version'].to_f <= 14.04
    notifies :run, 'execute[libevent-clean]', :immediately
  else
    notifies :run, 'execute[hhvm-cmake]', :immediately
  end
end

if node['platform'] == "Ubuntu" and node['platform_version'].to_f <= 14.04
  include_recipe 'hhvm::_source_common_libevent'
end

execute 'hhvm-cmake' do
  command 'cmake .'
  cwd hhvm_src
  environment (env)
  action :nothing
  notifies :run, 'execute[hhvm-make]', :immediately
end

execute 'hhvm-make' do
  command "make -j #{node['hhvm']['source']['make_jobs'].to_s} && make install"
  cwd hhvm_src
  environment (env)
  creates '/usr/local/bin/hhvm'
  action :nothing
end
