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

  describe 'GET #index' do
    it 'assigns @rooms' do
      get :index
      expect(assigns(:rooms)).to eq(rooms)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('rooms/index')
    end
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'Get #new' do
    context 'success with login user' do
      it 'returns a brand new room instance' do
        login(current_user)
        get :new
        expect(assigns(:room).attributes).to eq(Room.new.attributes)
      end
      it 'renders the new template' do
        login(current_user)
        get :new
        expect(response).to render_template('rooms/new')
      end
    end
    context 'failure with not login user' do
      it 'redirects to login page' do
        get :new
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST #create' do
    let(:param) {{
      room: {
        screen_name: 'test room',
        room_name: 'TEST ROOM',
        description: 'yo',
        private: false
      }
    }}
    context 'failure with not login user' do
      it 'renders index page' do
        pending('error handling')
        expect do
          post :create
        end.to change(Room, :count).by(0)
        expect(response).to render_template('rooms/index')
      end
    end
    context 'success with login user' do
      it 'creates new room' do
        login(current_user)
        expect do
          post :create, params: param
        end.to change(Room, :count).by(1)
      end
      it 'creates new membership' do
        login(current_user)
        expect do
          post :create, params: param
        end.to change(Membership, :count).by(1)
        membership = Membership.last
        expect(membership.room_id).to eq(Room.last.id)
        expect(membership.authority).to eq('administrator')
        expect(membership.memberable_id).to eq(current_user.id)
        expect(membership.memberable_type).to eq('User')
      end
      it 'redirects to show page' do
        login(current_user)
        post :create, params: param
        expect(response.status).to eq(302)
        expect(response).to redirect_to(room_path(Room.last.friendly_id))
      end
    end
  end
end
