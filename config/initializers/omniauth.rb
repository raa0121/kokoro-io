Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :github, ENV['OAUTH_GITHUB_KEY'], ENV['OAUTH_GITHUB_SECRET']
end
