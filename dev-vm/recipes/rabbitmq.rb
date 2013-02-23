require_recipe "rabbitmq"
require_recipe "rabbitmq-management"

apt_repository "php-amqp" do
  uri "http://ppa.launchpad.net/managedit/php-extensions/ubuntu"
  distribution "oneiric"
  components ["main"]
  key "F9E66E70"
  keyserver "keyserver.ubuntu.com"
  action :add
end
package "php5-amqp"