require 'rails_helper'

RSpec.describe "access_tokens/index", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user
    assign(:access_tokens, [
      AccessToken.create!(
        user: user,
        name: "Name1",
        token: "Token1",
        essential: false
      ),
      AccessToken.create!(
        user: user,
        name: "Name2",
        token: "Token2",
        essential: false
      )
    ])
  end

  it "renders a list of access_tokens" do
    render
    assert_select "tr>td", :text => "Name1".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
    assert_select "tr>td>div>input", :count => 2
    assert_select "tr>td>div>input[value='Token1']", :count => 1
    assert_select "tr>td>div>input[value='Token2']", :count => 1
  end
end
