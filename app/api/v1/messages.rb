module V1
  class Messages < Grape::API
    helpers RequestHelper

    resource 'messages' do
      before do
        authenticate!
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
