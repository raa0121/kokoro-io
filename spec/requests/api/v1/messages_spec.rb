require 'time'
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
  let(:outdated_message) { messages.order('id ASC').first }
  let(:latest_message) { messages.order('id DESC').first }
  let(:chattable_messages_desc) { room.messages.order('id DESC') }

  let(:headers) { {'X-Access-Token' => user.primary_access_token.token} }
  let(:path) { "/api/v1/rooms/#{ room.screen_name }/messages" }
  let(:params) { {} }

  describe 'GET /api/v1/rooms/:screen_name/messages' do
    let (:request) do
      get path, headers: headers, params: @params
    end

    it 'returns 200' do
      request
      expect(response.status).to eq(200)
    end

    it 'returns messages default length' do
      request
      expect(json(response.body).length).to eq(30)
    end

    context 'passed a limit parameter' do
      it 'returns number of specified.' do
        @params = { limit: 10 }
        request
        expect(json(response.body).length).to eq(10)
      end

      it 'returns datas which are ordered descending by primary key' do
        limit = 10
        @params = { limit: limit }
        request
        expect(json(response.body).map {|i| i['id'] }).to eq(chattable_messages_desc.limit(limit).map {|i| i.id})
      end
    end

    context 'passed a before_id parameter' do
      it 'returns datas which do not include passed id' do
        @params = { before_id: latest_message.id }
        request
        expect(json(response.body).map {|i| i['id'] }.include?(latest_message.id)).to be false
      end
    end

    it 'returns messages with limit and before_id' do
      @params = { limit: 10, before_id: latest_message.id }
      request
      expect(json(response.body).length).to eq(10)
    end

    context 'messages' do
      it 'includes iso8601 formated published_at field' do
        @params = { limit: 1 }
        request
        expect(Time.iso8601(json(response.body)[0]['published_at'])).to be_truthy
      end
    end
  end
end
