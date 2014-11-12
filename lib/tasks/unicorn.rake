namespace :unicorn do

  desc "Start unicorn or restart if it's already running"
  task(:start) {
    if unicorn_pid
      Rake::Task['unicorn:restart'].invoke
    else
      config = Rails.root.join("config", "unicorn.rb")
      env    = ENV['RAILS_ENV'] || "development"
      `bundle exec unicorn_rails -D -c #{config} -E #{env}`
    end
  }

  desc "Stop unicorn"
  task(:stop) do
    unicorn_signal :QUIT if unicorn_pid
  end

  desc "Restart unicorn with USR2"
  task(:restart) { unicorn_signal :USR2 }

  desc "Increment number of worker processes"
  task(:increment) { unicorn_signal :TTIN }

  desc "Decrement number of worker processes"
  task(:decrement) { unicorn_signal :TTOU }

  desc "Unicorn pstree (depends on pstree command)"
  task(:pstree) do
    puts `pstree '#{unicorn_pid}'`
  end

  def unicorn_signal signal
    Process.kill signal, unicorn_pid if unicorn_pid
  end

  def unicorn_pid
    pid_file = Rails.root.join("tmp", "pids", "unicorn.pid")
    if File.exists? pid_file
      begin
        File.read( Rails.root.join("tmp", "pids", "unicorn.pid") ).to_i
      rescue Errno::ENOENT
        raise "Unicorn doesn't seem to be running"
      end
    else
      nil
    end
  end
end
