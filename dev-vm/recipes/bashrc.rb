template "/home/#{node[:vm][:bashrc][:user]}/.bashrc" do
  source "bashrc.erb"
  owner node[:vm][:bashrc][:user]
  group node[:vm][:bashrc][:user]
  variables({
    :paths => node[:vm][:bashrc][:paths],
    :envs => node[:vm][:bashrc][:envs]
  })
end