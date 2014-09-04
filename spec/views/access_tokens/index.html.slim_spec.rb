require 'rails_helper'

RSpec.describe "access_tokens/index", :type => :view do
  before(:each) do
    assign(:access_tokens, [
      AccessToken.create!(
        :user => nil,
        :name => "Name",
        :token => "Token1"
      ),
      AccessToken.create!(
        :user => nil,
        :name => "Name",
        :token => "Token2"
      )
    ])
  end

  it "renders a list of access_tokens" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Token1".to_s, :count => 1
    assert_select "tr>td", :text => "Token2".to_s, :count => 1
  end
end
