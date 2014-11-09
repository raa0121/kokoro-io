require 'pathname'

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 2)
timeout 25
preload_app true

dir = Pathname.new(File.expand_path __FILE__).parent.parent
working_directory dir
pid "#{dir}/tmp/pids/unicorn.pid"
stderr_path "#{dir}/log/unicorn.log"
stdout_path "#{dir}/log/unicorn.log"

listen "/tmp/unicorn.kokoro-io.sock", backlog: 1024

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
