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
        ActionController::Parameters.new(params).permit(
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
        requires :display_name, type: String
        requires :screen_name, type: String
        requires :description, type: String
        optional :private, type: Boolean
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
        requires :id, type: String
        optional :screen_name, type: String
        optional :display_name, type: String
        optional :description, type: String
        optional :private, type: Boolean
      end
      route_param :id do
        put do
          room = Room.find_by(id: params[:id])
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
        requires :id, type: String
      end
      route_param :id do
        delete do
          room = Room.find_by(id: params[:id])
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
