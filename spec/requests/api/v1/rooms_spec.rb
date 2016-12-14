require 'rails_helper'

RSpec.describe API::Root::V1::Rooms, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:rooms) { user.chattable_rooms }
  let(:headers) { {'X-Access-Token' => user.access_tokens.first.token} }
  let(:path) { '/api/v1/rooms' }
  describe 'GET /api/v1/rooms' do
    it 'returns all chattable rooms' do
      get path, headers: headers, params: {}
      expect(response.status).to eq(200)
      expect(response.body).to eq(user.rooms.to_json)
    end
  end

  describe 'GET /api/v1/rooms/:id' do
    let(:room) { user.chattable_rooms.first }
    it 'returns 200 status' do
      get "#{path}/#{room.id}", headers: headers, params: {}
      expect(response.status).to eq(200)
    end

    it 'returns an information about queried room' do
      get "#{path}/#{room.id}", headers: headers, params: {}
      expect(response.body).to eq(room.to_json)
    end
  end

  describe 'POST /api/v1/rooms' do
    it 'successes to create a new room' do
      params = {
        room_name: 'nice_heya',
        screen_name: 'nice_mieru_heya',
        private: false,
        description: 'this room is absolutely nice'
      }
      rooms  # NOTE: seems likely to evaluate once for record count.
      expect {
        post path, headers: headers, params: params
      }.to change(Room, :count).by(1)
    end
  end
end
