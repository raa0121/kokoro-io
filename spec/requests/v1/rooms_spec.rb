require 'rails_helper'

describe API::Root::V1::Rooms do
  context 'GET /api/v1/rooms' do
    let(:public_rooms) { FactoryGirl.create_list(:room, 10, :public) }
    let(:private_rooms) { FactoryGirl.create_list(:room, 10, :private) }
    let(:user) { FactoryGirl.create(:user) }
    it 'returns all public rooms' do
      headers = {'X-Access-Token' => user.access_tokens.first.token}
      get '/api/v1/rooms', headers: headers, params: {}
      expect(response.status).to eq(200)
      expect(response.body).to eq user.rooms.to_json
    end
  end
end
