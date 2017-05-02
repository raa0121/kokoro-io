
if Rails.env.development?
  reloader = ActiveSupport::FileUpdateChecker.new(Dir['app/api/*']) {
    Rails.application.reload_routes!
  }

  ActiveSupport::Reloader.to_prepare do
    reloader.execute_if_updated
  end

end
