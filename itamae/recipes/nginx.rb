

package "nginx"

template "/etc/nginx/conf.d/kokoro.conf" do
  source "remote_files/nginx.conf.erb"
  notifies :reload, "service[nginx]"
end

service "nginx" do
  subscribes :reload, "template[/etc/nginx/conf.d/kokoro.conf]"
  action :enable
end

# template "/etc/nginx/nginx.conf" do
#   source "remote_files/nginx.conf.erb"
#   notifies :reload, "service[nginx]"
# end
