module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      if ( access_token = request.headers['X-Access-Token'] )
        # For WebSocket client which supports additional custom headers at upgrade request
        AccessToken.find_by(token: access_token).user
      else
        # For webbrowser's WebSocket object
        User.find(env['warden'].user.id)
      end
    rescue
      reject_unauthorized_connection
    end

  end
end
