module V1
  module RequestHelper
    def authenticate!
      set_current_user
      error!('Invalid Token', 401) unless @user
    end

    def session
      env[Rack::Session::Abstract::ENV_SESSION_KEY]
    end

    def current_user
      @user
    end

    def set_current_user
      access_token = request.headers['X-Access-Token']
      user = AccessToken.find_by(token: access_token).try(:user)
      return nil unless user
      @user = user
    end
  end
end
