module V1
  class RoomsEntity < Grape::Entity
    expose :name, documentation: {type: String, desc: 'A room name which is treated as a room id'}
  end

  class Rooms < Grape::API
    helpers RequestHelper

    resource 'rooms', desc: 'room' do
      # GET /v1/rooms
      before do
        authenticate!
      end
      desc 'get all chattable rooms', {
        entity: RoomsEntity,
        response: {isArray: true, entity: RoomsEntity}
      }
      get do
        @user.chattable_rooms
      end
    end
  end
end
