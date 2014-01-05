libevent_src = File.join(node['hhvm']['source']['layout']['working_dir'], 'libevent')

git 'libevent' do
  repository node['hhvm']['source']['libevent_repository']
  reference node['hhvm']['source']['libevent_revision']
  destination libevent_src
  action :sync
  notifies :run, 'execute[libevent-clean]', :immediately
end

execute 'libevent-clean' do
  command 'make clean; git clean -dfX'
  cwd libevent_src
  action :nothing
  only_if "test -d #{libevent_src} && git --git-dir=#{libevent_src}/.git status"
  notifies :run, 'execute[libevent-reset]', :immediately
  notifies :run, 'execute[libevent-patch]', :immediately
end

execute 'libevent-reset' do
  command 'git reset --hard'
  cwd libevent_src
  action :nothing
  only_if "test -d #{libevent_src} && git --git-dir=#{libevent_src}/.git status"
end

execute 'libevent-patch' do
  patch = File.join(node['hhvm']['source']['layout']['working_dir'], 'hhvm', 'hphp', 'third_party', 'libevent-1.4.14.fb-changes.diff')

  command "cat #{patch} | patch -p1"
  cwd libevent_src
  only_if "cat #{patch} | patch -p1 --dry-run", :cwd => libevent_src
  notifies :run, 'execute[libevent-autogen]', :immediately
end

execute 'libevent-autogen' do
  command './autogen.sh'
  cwd libevent_src
  not_if { File.exist?(File.join(libevent_src, 'Makefile.in')) }
  notifies :run, 'execute[libevent-configure]', :immediately
end

execute 'libevent-configure' do
  command './configure --prefix='.concat(node['hhvm']['source']['layout']['prefix'])
  cwd libevent_src
  not_if { File.exist?(File.join(libevent_src, 'Makefile')) }
  notifies :run, 'execute[libevent-make]', :immediately
end

execute 'libevent-make' do
  command "make -j#{node['hhvm']['source']['make_jobs'].to_s} && make install"
  cwd libevent_src
  not_if { Dir.exist?(File.join(libevent_src, '.libs')) }
  notifies :run, 'execute[hhvm-cmake]', :immediately
end
