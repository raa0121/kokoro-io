require 'rails_helper'

RSpec.describe "bots/new", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    session[:user_id] = user.id
    assign(:bot, Bot.new(
      user: user,
      access_token: "MyString",
      display_name: "display_name",
      screen_name: "MyString",
      status: 10
    ))
  end

  it "renders new bot form" do
    render

    assert_select "form[action=?][method=?]", bots_path, "post" do

      assert_select "input#bot_display_name[name=?]", "bot[display_name]"

      assert_select "input#bot_screen_name[name=?]", "bot[screen_name]"

      assert_select "select#bot_status[name=?]", "bot[status]"
    end
  end
end
