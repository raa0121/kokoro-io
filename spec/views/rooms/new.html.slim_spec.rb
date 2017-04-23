require 'rails_helper'

RSpec.describe "rooms/new", :type => :view do
  before(:each) do
    assign(:room, Room.new(
      :display_name => "MyString",
      :screen_name => "MyString",
      :private => false
    ))
  end

  it "renders new room form" do
    render

    assert_select "form[action=?][method=?]", rooms_path, "post" do

      assert_select "input#room_display_name[name=?]", "room[display_name]"

      assert_select "input#room_screen_name[name=?]", "room[screen_name]"

      assert_select "input#room_private[name=?]", "room[private]"
    end
  end
end
