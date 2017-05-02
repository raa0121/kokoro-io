
if Rails.env.development?
  reloader = ActiveSupport::FileUpdateChecker.new(Dir['app/api/*']) {
    Rails.application.reload_routes!
  }

  ActionDispatch::Callbacks.to_prepare do
    reloader.execute_if_updated
  end

end
