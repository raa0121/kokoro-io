require 'rails_helper'

RSpec.describe "access_tokens/edit", :type => :view do
  before(:each) do
    @access_token = assign(:access_token, AccessToken.create!(
      :user => nil,
      :name => "MyString",
      :token => "MyString"
    ))
  end

  it "renders the edit access_token form" do
    render

    assert_select "form[action=?][method=?]", access_token_path(@access_token), "post" do

      assert_select "input#access_token_user_id[name=?]", "access_token[user_id]"

      assert_select "input#access_token_name[name=?]", "access_token[name]"

      assert_select "input#access_token_token[name=?]", "access_token[token]"
    end
  end
end
