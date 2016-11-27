require 'rails_helper'

RSpec.describe RoomsController, :type => :controller do
  let(:valid_public_attributes) {
    {
      room_name: 'public_room',
      screen_name: 'sugoi_public_room',
      private: false,
      description: 'sugoi desu'
    }
  }

  let(:valid_private_attiutes) {
    {
      room_name: 'private_room',
      screen_name: 'sugoi_private_room',
      private: true,
      description: 'himitsu desu'
    }
  }

  let(:rooms) { FactoryGirl.create_list(:room, 10, :public) }
  let(:current_user) { FactoryGirl.create(:user) }

  describe 'GET index' do
    it 'assigns @rooms' do
      get :index
      expect(assigns(:rooms)).to eq(rooms)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'is occured an error with not login user' do
      expect do
        post :create
      end.to change(Room, :count).by(0)
      expect(response.status).to eq(302)
    end
    it 'creates new room' do
      session[:user_id] = current_user.id
      expect do
        post(:create, room: {
          screen_name: 'test room',
          room_name: 'TEST ROOM',
          description: 'yo',
          private: false
        })
      end.to change(Room, :count).by(1)
      expect(response.status).to eq(302)
    end
  end
end
