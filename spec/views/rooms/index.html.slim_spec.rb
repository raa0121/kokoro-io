require 'rails_helper'

RSpec.describe "rooms/index", :type => :view do
  before(:each) do
    user = User.create!(
      provider: 'github',
      uid: 'test',
      screen_name: 'name',
      display_name: 'user',
      avatar_url: 'htt://hi.com/hi.jpg'
    )
    allow(view).to receive(:current_user).and_return(user)
    assign(:rooms, [
      user.rooms.create!(
        display_name: "display_name1",
        screen_name: "Room Name1",
        description: "Hi!1",
        private: false
      ),
      user.rooms.create!(
        display_name: "display_name2",
        screen_name: "Room Name2",
        description: "Hi!2",
        private: false
      )
    ])
  end

  it "renders a list of rooms" do
    render
    assert_select "tr>td>a", :text => "Room Name1".to_s, :count => 1
    assert_select "tr>td>a", :text => "Room Name2".to_s, :count => 1
    assert_select "tr>td", :text => "Hi!1".to_s, :count => 1
    assert_select "tr>td", :text => "Hi!2".to_s, :count => 1
  end
end
