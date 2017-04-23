require 'rails_helper'

RSpec.describe "bots/show", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'display_name1',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    allow(view).to receive(:current_user).and_return(user)
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
    expect(rendered).to match(/display_name1/)
  end
end
