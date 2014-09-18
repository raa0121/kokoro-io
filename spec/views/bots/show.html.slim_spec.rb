require 'rails_helper'

RSpec.describe "bots/show", :type => :view do
  before(:each) do
    @bot = assign(:bot, Bot.create!(
      :user => nil,
      :access_token => "Access Token",
      :bot_name => "Bot Name",
      :screen_name => "Screen Name",
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Access Token/)
    expect(rendered).to match(/Bot Name/)
    expect(rendered).to match(/Screen Name/)
    expect(rendered).to match(/1/)
  end
end
