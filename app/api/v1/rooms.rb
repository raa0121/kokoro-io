module V1
  class Rooms < Grape::API
    helpers RequestHelper

    resource 'rooms', desc: 'room' do
      before do
        authenticate!
      end
      desc 'get all chattable rooms'
      get do
        @user.chattable_rooms
      end
    end
  end
end
