node.set['mysql']['server_root_password'] = "root"

require_recipe "mysql::server"
package "phpmyadmin"

link "/etc/apache2/sites-enabled/phpmyadmin.conf" do
  to "/etc/phpmyadmin/apache.conf"
  notifies :reload, resources(:service => "apache2"), :delayed
end

# Create databases
node[:vm][:mysql][:databases].each do |database|
  execute "add-mysql-db-#{database}" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
        "CREATE DATABASE #{database};\" " +
        "mysql"
    action :run
    ignore_failure true
  end
end

# Create users
node[:vm][:mysql][:users].each do |user|
  execute "revoke-mysql-perms-#{user[:username]}" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -B -N -e \"REVOKE ALL PRIVILEGES, GRANT OPTION FROM #{user[:username]}\""
    action :run
    ignore_failure true
  end

  execute "remove-mysql-user-#{user[:username]}" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -B -N -e \"DROP USER #{user[:username]}\""
    action :run
    ignore_failure true
  end
  execute "add-mysql-user-#{user[:username]}" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -B -N -e \"CREATE USER #{user[:username]} IDENTIFIED BY '#{user[:password]}'\""
    action :run
    ignore_failure true
  end

  execute "grant-mysql-perms-#{user[:username]}" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -B -N -e \"GRANT ALL on *.* to #{user[:username]}\""
    action :run
    ignore_failure true
  end
end
