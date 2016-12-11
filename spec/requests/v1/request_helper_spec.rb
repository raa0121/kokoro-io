require 'rails_helper'

describe API::Root::V1::RequestHelper do
  context '#authenticate!' do
    context 'occures a 401 error' do
      it 'because user was not found' do

      end
    end
  end
  context '#set_current_user' do
    context 'returns nil' do
      it 'because no user was found by an access token' do
      end
    end
    context 'sets user instance to @user' do
      let(:user) { FactoryGirl.create(:user) }

      it 'found by an access token' do
        controller.request['X-Access-Token'] = user.access_tokens.first.token
        result = set_current_user
        expect(result).to eq(user)
      end
    end
  end
end
