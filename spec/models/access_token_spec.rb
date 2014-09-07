require 'rails_helper'

RSpec.describe AccessToken, :type => :model do

  describe "generate_token" do

    it "generates sha256 token" do
      expect(AccessToken.generate_token.size).to eq(64)
    end

    it "generates unique tokens" do
      tokens = 10.times.map{
        AccessToken.generate_token.size
      }
      expect(tokens.size).not_to eq(tokens.uniq.size)
    end

  end

end
