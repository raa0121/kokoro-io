module V1
  module RequestHelper
    extend Grape::API::Helpers
    def authenticate!
      set_current_user
      error!({message: 'Invalid Token', with:V1::Error}, 401) unless @user
      error!({message: 'API not enabled', with:V1::Error}, 401) unless @user.api_enabled?
      error!({message: 'Account suspended', with:V1::Error}, 401) if @user.suspended?
    end

    def session
      env[Rack::Session::Abstract::ENV_SESSION_KEY]
    end

    def set_current_user
      api_token = request.headers['X-Access-Token']
      user = AccessToken.find_by(token: api_token).try(:user)
      return nil unless user
      return nil if user.suspended?
      @user = user
    end
  end
end
