require 'rails_helper'

RSpec.describe "rooms/edit", :type => :view do
  before(:each) do
    @room = assign(:room, Room.create!(
      :room_name => "MyString",
      :screen_name => "MyString",
      :private => false
    ))
  end

  it "renders the edit room form" do
    render

    assert_select "form[action=?][method=?]", room_path(@room), "post" do

      assert_select "input#room_room_name[name=?]", "room[room_name]"

      assert_select "input#room_screen_name[name=?]", "room[screen_name]"

      assert_select "input#room_private[name=?]", "room[private]"
    end
  end
end
