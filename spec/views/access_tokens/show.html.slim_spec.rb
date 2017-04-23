require 'rails_helper'

RSpec.describe "access_tokens/show", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user
    @access_token = assign(:access_token, AccessToken.create!(
      user: user,
      name: "TokenName",
      token: "Token",
      essential: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/TokenName/)
    expect(rendered).to match(/Token/)
  end
end
