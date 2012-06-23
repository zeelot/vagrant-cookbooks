# Installs phing
ph = php_pear_channel "pear.phing.info" do
  action :discover
end
php_pear "phing" do
  action :install
  channel ph.channel_name
end