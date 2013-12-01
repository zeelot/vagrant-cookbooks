package "curl"
package "vim"
package "emacs"
package "php-elisp"
package "nodejs"
package "npm"
package "git-core"
package "memcached"
package "sqlite"
package "graphviz"

gem_package "compass" do
  action :install
  version node[:vm][:compass_version]
  provider Chef::Provider::Package::Rubygems
end

gem_package "foreman" do
  action :install
  version node[:vm][:foreman_version]
  provider Chef::Provider::Package::Rubygems
end
