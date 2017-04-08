module V1
  class Messages < Grape::API

    resource 'messages' do
      before do
        authenticate!
      end

      desc 'Returns recent messages in the room'
      params do
        requires :id, type: Integer
        requires :limit, type: Integer, default: 30
        requires :offset, type: Integer, default: 0
      end
      route_param :id do
        get do
          room = @user.chattable_rooms.find(params[:id])
          # TODO: use offset
          messages = room.messages.recent.limit(params[:limit])
        end
      end

      desc 'Creates a new message.'
      params do
        requires :room_id, type: Integer
        requires :message, type: String
      end
      post do
        room = @user.rooms.find_by(id: params[:room_id])
        message = room.messages.create!(
          publisher: @user,
          content: params[:message]
        )
      end

    end
  end
end
