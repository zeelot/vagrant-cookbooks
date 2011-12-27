node.set['mysql']['server_root_password'] = "root"

require_recipe "mysql::server"

# Create database
execute "add-mysql-db" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE DATABASE web_app;\" " +
      "mysql"
  action :run
  ignore_failure true
end