require 'rails_helper'

RSpec.describe "access_tokens/show", :type => :view do
  before(:each) do
    @access_token = assign(:access_token, AccessToken.create!(
      :user => nil,
      :name => "Name",
      :token => "Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Token/)
  end
end
