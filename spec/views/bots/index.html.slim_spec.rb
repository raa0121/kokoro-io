require 'rails_helper'

RSpec.describe "bots/index", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user
    allow(view).to receive(:current_user).and_return(user)
    assign(:bots, [
      FactoryGirl.create(:bot, user: user),
      FactoryGirl.create(:bot, user: user)
    ])
  end

  it "renders a list of bots" do
    render
    assert_select "tr>td>a", :text => /BotName\d+/.to_s, :count => 2
    assert_select "tr>td", :text => 'enabled'.to_s, :count => 1
    assert_select "tr>td", :text => 'disabled'.to_s, :count => 0
  end
end
