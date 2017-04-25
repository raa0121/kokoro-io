module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user_by_access_token
    end

    protected
    def find_user_by_access_token
      access_token = request.headers['X-Access-Token']
      AccessToken.find_by(token: access_token).try(:user)
    end

  end
end
