module V1
  class Rooms < Grape::API
    helpers RequestHelper

    resource 'rooms' do
      before do
        authenticate!
      end
      desc 'Return chattable rooms.'
      get do
        @user.chattable_rooms
      end

      desc 'Return a room.'
      params do
        requires :id, type: Integer
      end
      route_param :id do
        get do
          @user.chattable_rooms.find(params[:id])
        end
      end

      desc 'Creates a new room.'
      params do
        requires :room_name, type: String
        requires :screen_name, type: String
        requires :description, type: String
      end
      post do
        room = @user.rooms.create!(
          room_name: params['room_name'],
          screen_name: params['screen_name'],
          private: params['private'] || false,
          description: params['description']
        )
        membership = room.memberships.first
        membership.administer! if membership
      end
    end
  end
end
