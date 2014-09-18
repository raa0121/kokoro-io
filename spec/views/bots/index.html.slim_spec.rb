require 'rails_helper'

RSpec.describe "bots/index", :type => :view do
  before(:each) do
    assign(:bots, [
      Bot.create!(
        :user => nil,
        :access_token => "Access Token",
        :bot_name => "Bot Name",
        :screen_name => "Screen Name",
        :status => 1
      ),
      Bot.create!(
        :user => nil,
        :access_token => "Access Token",
        :bot_name => "Bot Name",
        :screen_name => "Screen Name",
        :status => 1
      )
    ])
  end

  it "renders a list of bots" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Access Token".to_s, :count => 2
    assert_select "tr>td", :text => "Bot Name".to_s, :count => 2
    assert_select "tr>td", :text => "Screen Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
