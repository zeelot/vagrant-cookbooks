# Make sure this exists if any web apps need it
directory "/home/vagrant/ssl" do
  mode 00755
  action :create
end

node[:vm][:web_apps].each do |app|
  if app[:enable_ssl]
    # Copy the SSL Cert
    cookbook_file "/home/vagrant/ssl/#{app[:server_name]}.server.crt" do
      source "ssl/#{app[:server_name]}.server.crt"
      mode 00644
    end
    cookbook_file "/home/vagrant/ssl/#{app[:server_name]}.server.key" do
      source "ssl/#{app[:server_name]}.server.key"
      mode 00644
    end
  end

  web_app app[:server_name] do
    if web_app app[:template]
      template web_app app[:template]
    end
    if web_app app[:enable_ssl]
      enable_ssl web_app app[:enable_ssl]
    end
    server_name app[:server_name]
    server_aliases app[:server_aliases]
    docroot app[:docroot]
    app_environment app[:app_environment]
    app_platform app[:app_platform]
    aliases app[:aliases]
  end
end

package "php5-xdebug"
