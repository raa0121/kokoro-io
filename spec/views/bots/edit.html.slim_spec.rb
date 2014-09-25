require 'rails_helper'

RSpec.describe "bots/edit", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      user_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    session[:user_id] = user.id
    @bot = assign(:bot, Bot.create!(
      :user => user,
      :access_token => "MyString",
      :bot_name => "MyString",
      :screen_name => "MyString",
      :status => 10
    ))
  end

  it "renders the edit bot form" do
    render

    assert_select "form[action=?][method=?]", bot_path(@bot), "post" do

      assert_select "input#bot_bot_name[name=?]", "bot[bot_name]"

      assert_select "input#bot_screen_name[name=?]", "bot[screen_name]"

      assert_select "select#bot_status[name=?]", "bot[status]"
    end
  end
end
