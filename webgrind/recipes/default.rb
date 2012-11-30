include_recipe "git"
include_recipe "xdebug"

git "#{node['webgrind']['install_path']}" do
  repository "git://github.com/jokkedk/webgrind.git"
  reference "master"
  action :sync
end

template "#{node['webgrind']['install_path']}/config.php" do
  source "config.php.erb"
  mode "0600"
  owner "vagrant"
  group "vagrant"
end

if node['webgrind']['webserver'] == "apache2"
  include_recipe "webgrind::apache2"
end