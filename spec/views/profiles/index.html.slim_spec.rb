require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        :display_name => "Display Name1",
        :screen_name => "screen_name1",
        :avatar_id => "Avatar",
        :available => false
      ),
      Profile.create!(
        :display_name => "Display Name2",
        :screen_name => "screen_name2",
        :avatar_id => "Avatar",
        :available => false
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "Display Name1".to_s, :count => 1
    assert_select "tr>td", :text => "screen_name1".to_s, :count => 1
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
