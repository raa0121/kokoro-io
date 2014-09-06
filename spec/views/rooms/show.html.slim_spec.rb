require 'rails_helper'

RSpec.describe "rooms/show", :type => :view do
  before(:each) do
    @room = assign(:room, Room.create!(
      :room_name => "Room Name",
      :screen_name => "Screen Name",
      :private => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Room Name/)
    expect(rendered).to match(/Screen Name/)
    expect(rendered).to match(/false/)
  end
end
