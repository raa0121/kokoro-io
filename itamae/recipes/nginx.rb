
service "nginx"

package "nginx"


template "/etc/nginx/nginx.conf" do
  source "remote_files/nginx.conf.erb"
  notifies :reload, "service[nginx]"
end
