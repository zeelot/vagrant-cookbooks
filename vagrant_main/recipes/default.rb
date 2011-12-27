# Making apache run as the vagrant user simplifies things when you ssh in
node.set["apache"]["user"] = "vagrant"
node.set["apache"]["group"] = "vagrant"

require_recipe "apt"

require_recipe "apache2"
require_recipe "apache2::mod_php5"
require_recipe "apache2::mod_rewrite"
require_recipe "apache2::mod_ssl"

require_recipe "php"
require_recipe "php::module_curl"
require_recipe "php::module_fileinfo"
require_recipe "php::module_gd"
require_recipe "php::module_memcache"
require_recipe "php::module_mysql"
require_recipe "php::module_sqlite3"

package "php5-xdebug";

require_recipe "rabbitmq"
require_recipe "rabbitmq-management"

# Had some issues with an upload path not being specified so we set one here
file "/etc/php5/apache2/conf.d/upload_path.ini" do
  owner "root"
  group "root"
  content "upload_tmp_dir = /tmp/web-app"
  action :create
end

web_app "localhost" do
  server_name "localhost"
  server_aliases ["*.localhost"]
  docroot "/home/vagrant/web-app/httpdocs"
end

apt_repository "php-amqp" do
  uri "http://ppa.launchpad.net/managedit/php-extensions/ubuntu"
  distribution "oneiric"
  components ["main"]
  key "F9E66E70"
  keyserver "keyserver.ubuntu.com"
  action :add
end
package "php5-amqp"

gem_package "compass" do
  action :install
  version "0.11.5"
  provider Chef::Provider::Package::Rubygems
end

# Add the vagrant user to the vboxsf group
group "vboxsf" do
  members 'vagrant'
  append true
end

# This fixes a bug in Ubuntu 11.10
file "/etc/php5/conf.d/sqlite.ini" do
  action :delete
end