require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        :display_name => "Display Name",
        :screen_name => "Screen Name",
        :avatar_id => "Avatar",
        :available => false
      ),
      Profile.create!(
        :display_name => "Display Name",
        :screen_name => "Screen Name",
        :avatar_id => "Avatar",
        :available => false
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    assert_select "tr>td", :text => "Screen Name".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
