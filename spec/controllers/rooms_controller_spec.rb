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
      post :create
      expect(response.status).to eq(302)
    end
  end
end
