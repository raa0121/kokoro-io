require 'rails_helper'

def set_token(request, token)
  request.headers['X-Access-Token'] = token
end

RSpec.describe API::Root::V1::RequestHelper, type: :helper do
  describe '#authenticate!' do
    context 'calls error! method' do
      it 'because user was not found' do
        # I think that this spec makes no sense.
        allow(helper).to receive(:set_current_user) { nil }
        allow(helper).to receive(:error!){ true }
        expect(helper.authenticate!).to be(true)
      end
    end
  end

  describe '#set_current_user' do
    context 'returns nil' do
      it 'because no user was found by an access token' do
        set_token(helper.request, '')
        result = helper.set_current_user
        expect(result).to be_nil
      end
    end
    context 'sets user instance to @user' do
      let(:user) { FactoryGirl.create(:user) }

      it 'found by an access token' do
        set_token(helper.request, user.access_tokens.first.token)
        result = helper.set_current_user
        expect(result).to eq(user)
      end
    end
  end
end
