require 'rails_helper'

RSpec.describe "rooms/show", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      user_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    allow(view).to receive(:current_user).and_return(user)
    @room = assign(:room, user.rooms.create!(
      display_name: "Room name",
      screen_name: "screen_name",
      description: "Hi!",
      private: false
    ))
    membership = @room.memberships.first
    membership.administrator! if membership
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Room name/)
    expect(rendered).to match(/Hi!/)
  end
end
