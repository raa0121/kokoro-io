require 'rails_helper'

RSpec.describe API::Root::V1::Rooms, type: :request do
  before { rooms }
  let(:user) { FactoryGirl.create(:user) }
  let(:rooms) { user.chattable_rooms }
  let(:headers) { {'X-Access-Token' => user.primary_access_token.token} }
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

  describe 'POST /api/v1/rooms' do
    let(:request) { post path, headers: headers, params: @params }
    context 'can create a new room' do
      it 'status is 201' do
        @params = {
          display_name: 'display_name1',
          screen_name: 'screen_name1',
          description: 'this is test room1'
        }
        request
        expect(response.status).to eq(201)
      end
      it 'with all params' do
        @params = {
          display_name: 'display_name2',
          screen_name: 'screen_name2',
          private: false,
          description: 'this is test room2'
        }
        expect { request }.to change(Room, :count).by(1)
      end
      it 'with only required params' do
        @params = {
          display_name: 'display_name3',
          screen_name: 'screen_name3',
          description: 'this is test room3'
        }
        expect { request }.to change(Room, :count).by(1)
      end
      it 'creator is administrator' do
        @params = {
          display_name: 'display_name4',
          screen_name: 'screen_name4',
          description: 'this is test room4'
        }
        request
        memberships = user.chattable_rooms.last.memberships
        expect(memberships.count).to eq(1)
        membership = memberships.first
        expect(membership.memberable_id).to eq(user.id)
        expect(membership.memberable_type).to eq('User')
        expect(membership.authority).to eq('administrator')
      end
    end
    context 'failed to create a new room' do
      let(:resp_400) do
        request
        expect(response.status).to eq(400)
      end
      context 'status is 400' do
        it 'no display_name passed' do
          @params = {
            screen_name: 'hoge',
            description: 'fuga'
          }
          resp_400
        end
        it 'no screen_name passed' do
          @params = {
            display_name: 'hoge',
            description: 'fuga'
          }
          resp_400
        end
        it 'no description passed' do
          @params = {
            display_name: 'hoge',
            screen_name: 'fuga'
          }
          resp_400
        end
      end
    end
  end

  describe 'PUT /api/v1/rooms/:id' do
    let(:room) { user.administrator_rooms.first }
    let(:request) { put "#{path}/#{room.id}", headers: headers, params: @params }
    context 'can update an administrable room' do
      it 'status is 204' do
        @params = { description: 'hoge' }
        request
        expect(response.status).to eq(204)
      end
      it 'without params' do
        @params = {}
        request
        updated = user.administrator_rooms.find(room.id)
        expect(response.status).to eq(204)
        expect(response.body).to be_truthy
        expect(updated.display_name).to eq(room.display_name)
        expect(updated.screen_name).to eq(room.screen_name)
        expect(updated.description).to eq(room.description)
        expect(updated.private).to eq(room.private)
        expect(updated.updated_at).to eq room.updated_at
      end
      it 'with params' do
        @params = {
          display_name: "updated_#{room.display_name}",
          screen_name: "u#{room.screen_name}",
          description: "updated_#{room.description}",
          private: !room.private
        }
        request
        updated = Room.find(room.id)
        expect(response.status).to eq(204)
        expect(response.body).to be_truthy
        expect(updated.display_name).to_not eq(room.display_name)
        expect(updated.screen_name).to_not eq(room.screen_name)
        expect(updated.description).to_not eq(room.description)
        expect(updated.private).to_not eq(room.private)
        expect(updated.updated_at).to be > room.updated_at
      end
    end
    context 'failed to update a room' do
      it 'not administrable' do
        user2 = FactoryGirl.create(:user)
        put "#{path}/#{user2.administrator_rooms.first.id}", headers: headers, params: {}
        expect(response.status).to eq(404)
      end
      it 'invalid screen_name params' do
        @params = {display_name: 1}
        request
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'DELETE /api/v1/rooms/:id' do
    let(:room) { user.administrator_rooms.first }
    let(:request) {  }
    it 'can delete an administrable room' do
      expect {
        delete "#{path}/#{room.id}", headers: headers, params: {}
      }.to change(Room, :count).by(-1)
      expect(response.status).to eq(204)
      expect(response.body).to be_truthy
    end
    it 'failed to delete an unadministrable room' do
      user2 = FactoryGirl.create(:user)
      delete "#{path}/#{user2.administrator_rooms.first.id}", headers: headers, params: {}
      expect(response.status).to eq(404)
    end
    it '存在しない部屋の削除に失敗する' do
      user2 = FactoryGirl.create(:user)
      delete "#{path}/999999999999", headers: headers, params: {}
      expect(response.status).to eq(404)
    end
  end
end
