require 'rails_helper'

RSpec.describe "access_tokens/index", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'UserName',
      user_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    assign(:access_tokens, [
      AccessToken.create!(
        :user => user,
        :name => "Name",
        :token => "Token1"
      ),
      AccessToken.create!(
        :user => user,
        :name => "Name",
        :token => "Token2"
      )
    ])
  end

  it "renders a list of access_tokens" do
    render
    assert_select "tr>td", :text => "UserName".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Token1".to_s, :count => 1
    assert_select "tr>td", :text => "Token2".to_s, :count => 1
  end
end
