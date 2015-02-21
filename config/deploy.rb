require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/unicorn'
require 'mina/foreman'
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, ENV['host'] || 'kokoro'
set :deploy_to, "/home/%s/kokoro-io" % (ENV['user'] || 'deploy')
set :repository, 'https://github.com/supermomonga/kokoro-io.git'
set :branch, 'master'
set :rails_env, ENV['env'] || 'development'
case ENV['env'] || 'development'
when 'test'
  set :bundle_options, lambda { %{ --without development --path "#{bundle_path}" --binstubs bin/ --deployment } }
when 'development'
  set :bundle_options, lambda { %{ --without test --path "#{bundle_path}" --binstubs bin/ --deployment } }
end
# set :foreman_sudo, false
set :foreman_app, 'kokoroio'
set :foreman_user, (ENV['user'] || 'deploy')

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', '.rbenv-vars', '.env', 'log', 'tmp/sockets', 'tmp/pids']

# Optional settings:
set :user, ENV['user'] || 'deploy'    # Username in the server to SSH to.
set :port, ENV['port'] || 2222     # SSH port number.
set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]

  queue! %[ssh -T git@github.com]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  pathes = [
            "/home/#{(ENV['user'] || 'deploy')}/.rbenv/shims",
            "/home/#{(ENV['user'] || 'deploy')}/.rbenv/bin",
            "/home/#{(ENV['user'] || 'deploy')}/.rbenv/shims",
            "/usr/local/sbin",
            "/usr/local/bin",
            "/usr/sbin",
            "/usr/bin",
            "/sbin",
            "/bin"
           ]
  queue! %[echo "PATH=#{pathes.join(':')}" > "#{deploy_to}/#{shared_path}/.env"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/.env'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/.rbenv-vars"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/.rbenv-vars'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'foreman:export'
      invoke :'foreman:restart'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

