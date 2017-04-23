require 'rails_helper'

RSpec.describe "profiles/new", type: :view do
  before(:each) do
    assign(:profile, Profile.new(
      :display_name => "MyString",
      :screen_name => "MyString",
      :avatar_id => "MyString",
      :available => false
    ))
  end

  it "renders new profile form" do
    render

    assert_select "form[action=?][method=?]", profiles_path, "post" do

      assert_select "input#profile_display_name[name=?]", "profile[display_name]"

      assert_select "input#profile_screen_name[name=?]", "profile[screen_name]"

      assert_select "input#profile_avatar_id[name=?]", "profile[avatar_id]"

      assert_select "input#profile_available[name=?]", "profile[available]"
    end
  end
end
