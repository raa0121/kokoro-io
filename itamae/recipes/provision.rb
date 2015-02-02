# encoding: utf-8

include_recipe './sudoers.rb'
include_recipe 'rtn_rbenv::user'
include_recipe './rbenv-vars.rb'
include_recipe './nginx.rb'
include_recipe './sqlite3.rb'
include_recipe './postgresql.rb'
include_recipe './nodejs.rb'
