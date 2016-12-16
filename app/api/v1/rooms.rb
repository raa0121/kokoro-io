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
        membership.administrator! if membership
      end

      desc 'Updates a room.'
      params do
        requires :id, type: Integer
        optional :screen_name, type: String
        optional :room_name, type: String
        optional :description, type: String
        optional :private, type: Boolean
      end
      route_param :id do
        put do
          room = @user.administrator_rooms.find(params[:id])
          screen_name = params['screen_name'] || room.screen_name
          room_name = params['room_name'] || room.room_name
          description = params['description'] || room.description
          room_private = params['private'] || room.private
          room.update!(
            screen_name: screen_name,
            room_name: room_name,
            description: description,
            private: room_private,
            updated_at: Time.now
          )
        end
      end
    end
  end
end
