require 'rails_helper'

RSpec.describe "rooms/index", :type => :view do
  before(:each) do
    assign(:rooms, [
      Room.create!(
        :room_name => "Room Name",
        :screen_name => "Screen Name",
        :private => false
      ),
      Room.create!(
        :room_name => "Room Name",
        :screen_name => "Screen Name",
        :private => false
      )
    ])
  end

  it "renders a list of rooms" do
    render
    assert_select "tr>td", :text => "Room Name".to_s, :count => 2
    assert_select "tr>td", :text => "Screen Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
