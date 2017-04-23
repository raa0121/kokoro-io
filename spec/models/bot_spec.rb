require 'rails_helper'

RSpec.describe Bot, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:valid_param) {
    {
      user_id: user.id,
      profile_attributes: {
        display_name: 'display_name',
        screen_name: 'screen_name'
      },
      access_token: 'access_token',
      status: :enabled
    }
  }

  describe 'validation' do
    context 'when valid' do
      it do
        bot = Bot.new(valid_param)
        expect(bot).to be_valid
        bot.save
      end
    end

    context 'when invalid' do
      it 'without user_id' do
        param = valid_param.merge({user_id: nil})
        bot = Bot.new(param)
        bot.valid?
        expect(bot).not_to be_valid
      end

      it 'without access_token' do
        param = valid_param.merge({access_token: nil})
        bot = Bot.new(param)
        bot.valid?
        expect(bot).not_to be_valid
      end

      it 'without status' do
        param = valid_param.merge({status: nil})
        bot = Bot.new(param)
        bot.valid?
        expect(bot).not_to be_valid
      end
    end
  end

  describe '.generate_token' do
    it 'returns a token' do
      token = Bot.generate_token
      expect(token).not_to be_nil
    end
  end

  describe '#owner?' do
    it 'returns true with owner user' do
      bot = Bot.new(user: user)
      result = bot.owner? user
      expect(result).to be true
    end

    it 'returns false with not onwer user' do
      bot = Bot.new(user: user)
      result = bot.owner? user2
      expect(result).to be false
    end
  end
end
