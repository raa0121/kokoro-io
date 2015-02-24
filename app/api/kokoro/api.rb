module Kokoro
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    helpers do
      def session
        env[Rack::Session::Abstract::ENV_SESSION_KEY]
      end

      def current_user
        @current_user ||= User.where(id: session[:user_id]).first if session
      end

      def authenticate!
        error! '401 Unauthorized', 401 unless current_user
      end
    end

    resource :authenticated_user do
      before do
        authenticate!
      end

      desc "Get user rooms"
      get :rooms do
        current_user.chattable_rooms
      end
    end

  end
end
