require 'rails_helper'

RSpec.describe "access_tokens/edit", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    session[:user_id] = user.id
    @access_token = assign(:access_token, AccessToken.create!(
      user: user,
      name: "MyString",
      token: "MyString",
      essential: false
    ))
  end

  it "renders the edit access_token form" do
    render

    assert_select "form[action=?][method=?]", access_token_path(@access_token), "post" do


      assert_select "input#access_token_name[name=?]", "access_token[name]"

    end
  end
end
