template node[:hhvm][:server_config][:path] do
  source node[:hhvm][:server_config][:template]
  cookbook node[:hhvm][:server_config][:cookbook]
  mode "0664"
end

template node[:hhvm][:nginx][:path] do
  source node[:hhvm][:nginx][:template]
  cookbook node[:hhvm][:nginx][:cookbook]
  mode "0664"
end