require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do

  describe "caret" do
    describe "with default values" do
      it "Should have only left space" do
        expect(helper.caret).to eq(%` <span class="caret"></span>`)
      end
    end
  end

end
