package "build-essential"
package "libssl-dev"
package "git"

# Install ruby-vars plugin
RBENV_VARS_USER = (node['rtn_rbenv']['user'] || 'deployer')
RBENV_VARS_USER_HOME = "/home/#{RBENV_VARS_USER}"
RBENV_VARS_PATH = "#{RBENV_VARS_USER_HOME}/.rbenv/plugins/rbenv-vars"
git RBENV_VARS_PATH do
  repository "https://github.com/sstephenson/rbenv-vars.git"
end

