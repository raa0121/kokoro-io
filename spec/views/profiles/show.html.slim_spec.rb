require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :display_name => "Display Name",
      :screen_name => "Screen Name",
      :avatar_id => "Avatar",
      :available => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(/Screen Name/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/false/)
  end
end
