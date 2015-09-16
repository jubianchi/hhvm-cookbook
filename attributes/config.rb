default[:hhvm][:pid] = "/var/run/hhvm/pid"
default[:hhvm][:server][:port] = 9000
default[:hhvm][:server][:type] = "fastcgi"
default[:hhvm][:server][:default_document] = "index.php"
default[:hhvm][:log][:use_log_file] =  true
default[:hhvm][:log][:file] = "/var/log/hhvm/error.log"
default[:hhvm][:repo][:central][:path] = "/var/run/hhvm/hhvm.hhbc"

default[:hhvm][:fastcgi_pass] = "127.0.0.1:9000"

default[:hhvm][:server_config][:path] = "/etc/hhvm/server.ini"
default[:hhvm][:server_config][:template] = "server.ini.erb"
default[:hhvm][:server_config][:cookbook] = "hhvm"

default[:hhvm][:nginx][:path] = "/etc/nginx/hhvm.conf"
default[:hhvm][:nginx][:template] = "nginx.conf.erb"
default[:hhvm][:nginx][:cookbook] = "hhvm"

default[:hhvm][:configs] = {}