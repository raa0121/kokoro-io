require 'test_helper'

class BotTest < ActiveSupport::TestCase
  def setup
    @user = users(:stan)
    @param = {
      bot_name: 'bot_name',
      screen_name: 'screen_name',
      access_token: 'access_token',
      status: :enabled,
      user_id: @user.id
    }
  end

  test 'validates for saving' do
    bot = Bot.new
    assert_not bot.valid?
    # user_id is required.
    bot.user_id = @user.id
    assert_not bot.valid?
    # bot_name is required.
    bot.bot_name = 'bot_name'
    assert_not bot.valid?
    # screen_name is required.
    bot.screen_name = 'screen_name'
    assert_not bot.valid?
    # access_token is required.
    bot.access_token = 'access_token'
    assert_not bot.valid?
    # status is required.
    bot.status = :enabled
    assert bot.valid?
    assert_difference 'Bot.count', 1 do
      bot.save
    end
  end

  test 'validates bot_name' do
    @param[:bot_name] = nil
    bot = Bot.new(@param)
    # bot_name is required.
    assert_not bot.valid?
    # over length.
    bot.bot_name = 'a' * 256
    assert_not bot.valid?
    # corner case.
    bot.bot_name = 'a' * 255
    assert bot.valid?
    bot.bot_name = 'one'
    assert_difference 'Bot.count', 1 do
      bot.save
    end

    # bot_name must be unique.
    bot2 = Bot.new(@param)
    bot2.bot_name = bot.bot_name
    assert_not bot2.save
  end

  test 'validates screen_name' do
    @param[:screen_name] = nil
    bot = Bot.new(@param)
    # screen_name is required.
    assert_not bot.valid?
    # over length.
    bot.screen_name = 'a' * 65
    assert_not bot.valid?
    # corner case.
    bot.screen_name = 'a' * 64
    assert bot.valid?
    bot.screen_name = 'one'
    assert_difference 'Bot.count', 1 do
      bot.save
    end
  end

  test 'validates access_token' do
    @param[:access_token] = nil
    bot = Bot.new(@param)
    # access_token is required.
    assert_not bot.valid?
    bot.access_token = 'one'
    assert_difference 'Bot.count', 1 do
      bot.save
    end

    # access_token must be unique.
    bot2 = Bot.new(@param)
    bot2.access_token = bot.access_token
    assert_not bot2.save
  end

  test 'validates status' do
    @param[:status] = nil
    bot = Bot.new(@param)
    # status is requied.
    assert_not bot.valid?
    # status must be `enabled(10)` or `disabled(20)`.
    assert_raises ArgumentError do
      bot.status = :invalid
    end
    bot.status = :enabled
    assert bot.valid?
    bot.status = 10
    assert bot.valid?
    bot.status = :disabled
    assert bot.valid?
    bot.status = 20
    assert bot.valid?
    assert_difference 'Bot.count', 1 do
      bot.save
    end
  end

  test 'owner?' do
    bot = Bot.create(@param)
    assert bot.owner? @user
  end
end
