module V1
  class RoomEntity < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "レコードID"}
    expose :screen_name, documentation: {type: String, desc: "ルームID"}
    expose :display_name, documentation: {type: String, desc: "ルーム名"}
    expose :description, documentation: {type: String, desc: "ルーム説明"}
    expose :private, documentation: {type: 'boolean', desc: "プライベートルームかどうか"}
  end

  class Rooms < Grape::API

    helpers do
      def permitted_params
        ActionController::Parameters.new(params[:room] || {}).permit(
          :screen_name,
          :display_name,
          :description,
          :private
        )
      end
    end

    resource 'rooms' do
      before do
        authenticate!
      end

      desc 'Return chattable rooms.', {
        entity: RoomEntity,
        response: {isArray: true, entity: RoomEntity}
      }
      get do
        @user.chattable_rooms
      end

      desc 'Creates a new room.', {
        entity: RoomEntity,
        response: {isArray: false, entity: RoomEntity}
      }
      params do
        optional :room, type: Hash do
          requires :display_name, type: String
          requires :screen_name, type: String
          requires :description, type: String
          optional :private, type: Boolean
        end
      end
      post do
        room = @user.rooms.create(permitted_params)
        membership = room.memberships.first
        membership.administrator! if membership
        room
      end

      desc 'Updates a room.', {
        entity: RoomEntity,
        response: {isArray: false, entity: RoomEntity}
      }
      params do
        requires :screen_name, type: String
        optional :room, type: Hash do
          optional :screen_name, type: String
          optional :display_name, type: String
          optional :description, type: String
          optional :private, type: Boolean
        end
      end
      route_param :screen_name do
        put do
          room = Room.find_by(screen_name: params[:screen_name])
          if room && room.maintainable?(@user)
            if room.update(permitted_params)
              status 204
            else
              status 400
            end
          else
            status 404
          end
        end
      end

      desc 'Delete a room'
      params do
        requires :screen_name, type: String
      end
      route_param :screen_name do
        delete do
          room = Room.find_by(screen_name: params[:screen_name])
          if room && room.destroyable?(@user)
            if room.destroy
              status 204
            else
              status 400
            end
          else
            status 404
          end
        end
      end
    end
  end
end
