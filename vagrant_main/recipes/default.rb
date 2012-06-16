# For some reason, a fresh copy of my VM has issues booting up until this runs
execute "initial-sudo-apt-get-update" do
  command "apt-get update"
end

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

require_recipe "xdebug"

package "nodejs"
package "npm"
package "git-core"

# These can be defined in the Vagrantfile to install some extra needed packages
node[:app][:extra_packages].each do |extra_package|
  package extra_package
end

# Installs uglifyjs for the vagrant user
execute "install uglifyjs npm" do
  user "vagrant"
  group "vagrant"
  environment ({'HOME' => '/home/vagrant'})
  command "npm install uglify-js"
end

# Had some issues with an upload path not being specified so we set one here
file "/etc/php5/apache2/conf.d/upload_path.ini" do
  owner "root"
  group "root"
  content "upload_tmp_dir = /tmp/web-app"
  action :create
end

# Remove the 000-default site
apache_site "000-default" do
  enable false
end

web_app "localhost" do
  server_name node[:app][:server_name]
  server_aliases node[:app][:server_aliases]
  docroot node[:app][:docroot]
  kohana_environment node[:app][:kohana_environment]
end

gem_package "compass" do
  action :install
  version "0.11.5"
  provider Chef::Provider::Package::Rubygems
end

gem_package "foreman" do
  action :install
  version "0.26.1"
  provider Chef::Provider::Package::Rubygems
end

remote_file "/usr/bin/wkhtmltopdf" do
  source "http://zeelot.s3.amazonaws.com/cookbook-files/wkhtmltopdf-amd64-0.9.9"
  group "root"
  owner "root"
  mode "0755"
  checksum "c1047cca6bce10d3d1cf7fed4520f2f2be5be5176cba73cf550d0f87f530df3e"
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