# Make sure the bin directory exists
directory "/home/vagrant/bin" do
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
end

# Download the latest composer
remote_file "/home/vagrant/bin/composer" do
  source "http://getcomposer.org/composer.phar"
  mode 00755
  group "vagrant"
  owner "vagrant"
end