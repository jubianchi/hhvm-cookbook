glog_src = File.join(node['hhvm']['source']['layout']['working_dir'], 'google-glog')

subversion 'google-glog' do
  repository 'http://google-glog.googlecode.com/svn/trunk/'
  revision 'HEAD'
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

