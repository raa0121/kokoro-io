
service "postgresql"

package "postgresql"
package "postgresql-contrib"
package "libpq-dev"

execute "create postgresql user '#{node["pg"]["user"]}' and database '#{node["pg"]["database"]}'" do
  command %`echo "CREATE USER #{node["pg"]["user"]} WITH PASSWORD '#{node["pg"]["password"]}';"` | sudo -u postgres psql
  command %`echo "CREATE DATABASE #{node["pg"]["database"]} OWNER #{node["pg"]["user"]};"` | sudo -u postgres psql
  not_if %`sudo -u postgres psql postgres -tAc "SELECT 1 from pg_roles WHERE rolname='#{node["pg"]["user"]}';"`
end

