require 'rails_helper'

RSpec.describe "access_tokens/index", :type => :view do
  before(:each) do
    assign(:access_tokens, [
      AccessToken.create!(
        :user => nil,
        :name => "Name",
        :token => "Token"
      ),
      AccessToken.create!(
        :user => nil,
        :name => "Name",
        :token => "Token"
      )
    ])
  end

  it "renders a list of access_tokens" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
  end
end
