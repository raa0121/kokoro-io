require 'rails_helper'

RSpec.describe "bots/show", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'user_name1',
      user_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    view.stub(:current_user) { user }
    @bot = assign(:bot, Bot.new(
      user: user,
      access_token: "token1",
      bot_name: "bot_name1",
      screen_name: "Name1",
      status: 10
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/token1/)
    expect(rendered).to match(/bot_name1/)
    expect(rendered).to match(/Name1/)
    expect(rendered).to match(/user_name1/)
  end
end
