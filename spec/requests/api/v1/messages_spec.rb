require 'rails_helper'

RSpec.describe API::Root::V1::Messages, type: :request do
  before { messages }
  let(:user) { FactoryGirl.create(:user) }
  let(:room) { user.chattable_rooms.first }
  let(:messages) {
    40.times do
      FactoryGirl.create(:message,
        room: room,
        profile: user.profile,
        published_at: Time.now
      )
    end
    room.messages
  }

  let(:headers) { {'X-Access-Token' => user.primary_access_token.token} }
  let(:path) { "/api/v1/rooms/#{ room.screen_name }/messages" }

  describe 'GET /api/v1/rooms/:screen_name/messages' do
    it 'returns 200' do
      get path, headers: headers, params: {}
      expect(response.status).to eq(200)
    end

    it 'returns messages default length' do
      get path, headers: headers, params: {}
      expect(json(response.body).length).to eq(30)
    end

    it 'returns messages with limit' do
      get path, headers: headers, params: {
        limit: 10
      }
      expect(json(response.body).length).to eq(10)
    end

    it 'returns messages with offset' do
      get path, headers: headers, params: {
        offset: 20
      }
      expect(json(response.body).length).to eq(40 - 20)
    end

    it 'returns messages with limit and offset' do
      get path, headers: headers, params: {
        limit: 10,
        offset: 35
      }
      expect(json(response.body).length).to eq(40 - 35)
    end

  end

end
