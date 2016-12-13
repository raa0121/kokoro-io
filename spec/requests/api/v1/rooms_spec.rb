require 'rails_helper'

RSpec.describe API::Root::V1::Rooms, type: :request do
  let(:rooms) { FactoryGirl.create_list(:room, 10) }
  let(:user) { FactoryGirl.create(:user) }
  let(:headers) { {'X-Access-Token' => user.access_tokens.first.token} }
  describe 'GET /api/v1/rooms' do
    it 'returns all chattable rooms' do
      get '/api/v1/rooms', headers: headers, params: {}
      expect(response.status).to eq(200)
      expect(response.body).to eq(user.rooms.to_json)
    end
  end

  describe 'GET /api/v1/rooms/:id' do
    it 'returns a specified room by room id' do
      room = user.chattable_rooms.first
      get "/api/v1/rooms/#{room.id}", headers: headers, params: {}
      expect(response.status).to eq(200)
      expect(response.body).to eq(room.to_json)
    end
  end
end
