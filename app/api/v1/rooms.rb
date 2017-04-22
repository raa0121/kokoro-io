module V1
  class RoomEntity < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "ルームID"}
    expose :screen_name, documentation: {type: String, desc: "ルームID"}
    expose :room_name, documentation: {type: String, desc: "ルーム名"}
    expose :description, documentation: {type: String, desc: "ルーム説明"}
    expose :private, documentation: {type: 'boolean', desc: "プライベートルームかどうか"}
    expose :publisher_type, documentation: {type: String, desc: "発言者の種類 / User or Bot"}
    expose :published_at, documentation: {type: DateTime, desc: "発言日時"}
  end

  class Rooms < Grape::API

    helpers do
      def permitted_params
        ActionController::Parameters.new(params).permit(
          :screen_name,
          :room_name,
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
        requires :room_name, type: String
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
        requires :screen_name, type: String
        optional :room_name, type: String
        optional :description, type: String
        optional :private, type: Boolean
      end
      route_param :screen_name do
        put do
          status 204
          room = @user.administrator_rooms.find_by(screen_name: params[:screen_name])
          room.update(permitted_params)
        end
      end

      desc 'Delete a room'
      params do
        requires :screen_name, type: String
      end
      route_param :screen_name do
        delete do
          status 204
          room = @user.administrator_rooms.find_by(screen_name: params[:screen_name])
          if room.destroyable?(@user)
            room.destroy
          end
        end
      end
    end
  end
end
