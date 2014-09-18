require 'rails_helper'

RSpec.describe "bots/edit", :type => :view do
  before(:each) do
    @bot = assign(:bot, Bot.create!(
      :user => nil,
      :access_token => "MyString",
      :bot_name => "MyString",
      :screen_name => "MyString",
      :status => 1
    ))
  end

  it "renders the edit bot form" do
    render

    assert_select "form[action=?][method=?]", bot_path(@bot), "post" do

      assert_select "input#bot_user_id[name=?]", "bot[user_id]"

      assert_select "input#bot_access_token[name=?]", "bot[access_token]"

      assert_select "input#bot_bot_name[name=?]", "bot[bot_name]"

      assert_select "input#bot_screen_name[name=?]", "bot[screen_name]"

      assert_select "input#bot_status[name=?]", "bot[status]"
    end
  end
end
