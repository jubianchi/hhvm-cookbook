glog_src = File.join(node['hhvm']['source']['layout']['working_dir'], 'google-glog')

git 'google-glog' do
  repository 'https://github.com/google/glog.git'
  reference 'v0.3.4'
  destination glog_src
  action :sync
end

execute 'google-glog-configure' do
  command './configure --prefix='.concat(node['hhvm']['source']['layout']['prefix'])
  cwd glog_src
  not_if { File.exist?(File.join(glog_src, 'Makefile')) }
  notifies :run, 'execute[google-glog-make]', :immediately
end

execute 'google-glog-make' do
  command "make -j#{node['hhvm']['source']['make_jobs'].to_s} && make install"
  cwd glog_src
end
