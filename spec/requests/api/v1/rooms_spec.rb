require 'rails_helper'

RSpec.describe API::Root::V1::Rooms, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:rooms) { user.chattable_rooms }
  let(:headers) { {'X-Access-Token' => user.access_tokens.first.token} }
  let(:path) { '/api/v1/rooms' }

  describe 'GET /api/v1/rooms' do
    it 'returns 200' do
      get path, headers: headers, params: {}
      expect(response.status).to eq(200)
    end
    it 'returns all chattable rooms' do
      get path, headers: headers, params: {}

      expect(json(response.body).length).to eq(rooms.count)
    end
  end

  describe 'GET /api/v1/rooms/:id' do
    let(:room) { user.chattable_rooms.first }
    it 'returns 200' do
      get "#{path}/#{room.id}", headers: headers, params: {}
      expect(response.status).to eq(200)
    end

    it 'returns an information about queried room' do
      get "#{path}/#{room.id}", headers: headers, params: {}
      expect(response.body).to eq(room.to_json)
    end
  end

  describe 'POST /api/v1/rooms' do
    let(:request) { post path, headers: headers, params: @params }
    context 'successes to create a new room' do
      before { rooms }
      it 'returns 201' do
        @params = {
          room_name: 'room_name1',
          screen_name: 'screen_name1',
          description: 'this is test room1'
        }
        request
        expect(response.status).to eq(201)
      end
      it 'with all params' do
        @params = {
          room_name: 'room_name2',
          screen_name: 'screen_name2',
          private: false,
          description: 'this is test room2'
        }
        expect { request }.to change(Room, :count).by(1)
      end
      it 'with only required params' do
        @params = {
          room_name: 'room_name3',
          screen_name: 'screen_name3',
          description: 'this is test room3'
        }
        expect { request }.to change(Room, :count).by(1)
      end
      it 'creator is administrator' do
        @params = {
          room_name: 'room_name4',
          screen_name: 'screen_name4',
          description: 'this is test room4'
        }
        request
        memberships = user.chattable_rooms.last.memberships
        expect(memberships.count).to eq(1)
        membership = memberships.first
        expect(membership.memberable_id).to eq(user.id)
        expect(membership.memberable_type).to eq('User')
        expect(membership.authority).to eq('administer')
      end
    end
    context 'failures to create a new room' do
      let(:resp_400) do
        request
        expect(response.status).to eq(400)
      end
      context 'returns 400' do
        it 'no room_name passed' do
          @params = {
            screen_name: 'hoge',
            description: 'fuga'
          }
          resp_400
        end
        it 'no screen_name passed' do
          @params = {
            room_name: 'hoge',
            description: 'fuga'
          }
          resp_400
        end
        it 'no description passed' do
          @params = {
            room_name: 'hoge',
            screen_name: 'fuga'
          }
          resp_400
        end
      end
    end
  end
end
