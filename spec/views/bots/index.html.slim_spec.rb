require 'rails_helper'

RSpec.describe "bots/index", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    allow(view).to receive(:current_user).and_return(user)
    assign(:bots, [
      Bot.create!(
        :user => user,
        :access_token => "Access Token1",
        :bot_name => "bot_name1",
        :screen_name => "Screen Name",
        :status => 10
      ),
      Bot.create!(
        :user => user,
        :access_token => "Access Token2",
        :bot_name => "bot_name2",
        :screen_name => "Screen Name",
        :status => 20
      )
    ])
  end

  it "renders a list of bots" do
    render
    assert_select "tr>td>a", :text => "Screen Name".to_s, :count => 2
    assert_select "tr>td", :text => 'enabled'.to_s, :count => 1
    assert_select "tr>td", :text => 'disabled'.to_s, :count => 1
  end
end
