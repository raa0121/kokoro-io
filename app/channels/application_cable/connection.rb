module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      sec_websocket_protocol = request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL]
      access_token = sec_websocket_protocol.split(/,\s*/).find { |t|
        t.start_with?('access-token-')
      }&.sub(/^access-token-/, '')
      user = AccessToken.find_by(token: access_token)&.user
      if user
        user
      else
        reject_unauthoried_connection
      end
    end

  end
end
