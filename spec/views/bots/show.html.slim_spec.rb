require 'rails_helper'

RSpec.describe "bots/show", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user
    allow(view).to receive(:current_user).and_return(user)
    @bot = assign(:bot, FactoryGirl.create(:bot, user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/token1/)
    expect(rendered).to match(/display_name1/)
    expect(rendered).to match(/Name1/)
    expect(rendered).to match(/display_name1/)
  end
end
