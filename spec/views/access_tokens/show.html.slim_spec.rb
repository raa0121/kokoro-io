require 'rails_helper'

RSpec.describe "access_tokens/show", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'UserName',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    @access_token = assign(:access_token, AccessToken.create!(
      user: user,
      name: "Name",
      token: "Token",
      essential: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/UserName/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Token/)
  end
end
