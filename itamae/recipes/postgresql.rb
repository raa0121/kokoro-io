
service "postgresql"

package "postgresql"
package "postgresql-contrib"
package "libpq-dev"

execute "create postgresql role '#{node["pg"]["user"]}'" do
  command %`echo "CREATE USER #{node["pg"]["user"]} WITH PASSWORD '#{node["pg"]["password"]}';" | sudo -u postgres psql`
  not_if %`sudo -u postgres psql postgres -tAc "SELECT 1 from pg_roles WHERE rolname='#{node["pg"]["user"]}';" | grep 1`
end

execute "create postgresql database '#{node["pg"]["database"]}'" do
  command %`echo "CREATE DATABASE #{node["pg"]["database"]} OWNER #{node["pg"]["user"]};" | sudo -u postgres psql`
  not_if %`sudo -u postgres psql postgres -tAc "SELECT 1 from pg_database WHERE datname='#{node["pg"]["database"]}';" | grep 1`
end

