
template "/home/#{node["user"]}/.ssh/config" do
  source "remote_files/ssh_config"
end
