module V1
  class Rooms < Grape::API
    helpers RequestHelper

    resource 'rooms' do
      before do
        authenticate!
      end
      desc 'Returns chattable rooms.'
      get do
        @user.chattable_rooms
      end

      desc 'Retuan a room.'
      params do
        requires :id, type: Integer, desc: 'Room id.'
      end
      route_param :id do
        get do
          @user.chattable_rooms.find_by(params[:id])
        end
      end
    end
  end
end
