require 'rails_helper'

RSpec.describe "bots/new", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user
    session[:user_id] = user.id
    assign(:bot, FactoryGirl.create(:bot, user: user))
  end

  it "renders new bot form" do
    render

    assert_select "form[action=?][method=?]", bots_path, "post" do

      assert_select "input#bot_profile_attributes_display_name[name=?]", "bot[profile_attributes][display_name]"

      assert_select "input#bot_profile_attributes_screen_name[name=?]", "bot[profile_attributes][screen_name]"

      assert_select "select#bot_status[name=?]", "bot[status]"
    end
  end
end
