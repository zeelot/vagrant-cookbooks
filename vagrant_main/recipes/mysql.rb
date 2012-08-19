node.set['mysql']['server_root_password'] = "root"

require_recipe "mysql::server"
package "phpmyadmin"

link "/etc/apache2/sites-enabled/phpmyadmin.conf" do
  to "/etc/phpmyadmin/apache.conf"
  notifies :reload, resources(:service => "apache2"), :delayed
end

# Create database
execute "add-mysql-db" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE DATABASE web_app;\" " +
      "mysql"
  action :run
  ignore_failure true
end