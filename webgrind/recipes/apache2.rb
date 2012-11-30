include_recipe "apache2"

template "#{node['apache']['dir']}/sites-available/webgrind" do
  source "webgrind.conf.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

apache_site "webgrind"