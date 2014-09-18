require 'rails_helper'

RSpec.describe "bots/new", :type => :view do
  before(:each) do
    assign(:bot, Bot.new(
      :user => nil,
      :access_token => "MyString",
      :bot_name => "MyString",
      :screen_name => "MyString",
      :status => 1
    ))
  end

  it "renders new bot form" do
    render

    assert_select "form[action=?][method=?]", bots_path, "post" do

      assert_select "input#bot_user_id[name=?]", "bot[user_id]"

      assert_select "input#bot_access_token[name=?]", "bot[access_token]"

      assert_select "input#bot_bot_name[name=?]", "bot[bot_name]"

      assert_select "input#bot_screen_name[name=?]", "bot[screen_name]"

      assert_select "input#bot_status[name=?]", "bot[status]"
    end
  end
end
