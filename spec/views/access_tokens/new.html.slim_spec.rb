require 'rails_helper'

RSpec.describe "access_tokens/new", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      user_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    assign(:access_token, AccessToken.new(
      :user => user,
      :name => "MyString",
      :token => "MyString"
    ))
  end

  it "renders new access_token form" do
    render

    assert_select "form[action=?][method=?]", access_tokens_path, "post" do

      assert_select "select#access_token_user_id[name=?]", "access_token[user_id]"

      assert_select "input#access_token_name[name=?]", "access_token[name]"

      assert_select "input#access_token_token[name=?]", "access_token[token]"
    end
  end
end
