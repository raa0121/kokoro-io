require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "uniq_user_name" do

    describe "with github_user_name which isn't taken" do

      it "will be numbereized" do
        expect(User.uniq_user_name('kanari')).to eq('kanari')
      end

    end

    describe "with github_user_name which is already taken" do

      before do
        User.create provider: 'github', uid: 'test1', screen_name: 'name', user_name: 'kanari', avatar_url: 'htt://hi.com/hi.jpg'
        User.create provider: 'github', uid: 'test2', screen_name: 'name', user_name: 'benri', avatar_url: 'htt://hi.com/hi.jpg'
        User.create provider: 'github', uid: 'test3', screen_name: 'name', user_name: User.uniq_user_name('benri'), avatar_url: 'htt://hi.com/hi.jpg'
        User.create provider: 'github', uid: 'test4', screen_name: 'name', user_name: 'sugoi', avatar_url: 'htt://hi.com/hi.jpg'
      end

      it "can not be taken" do
        expect(User.uniq_user_name('kanari')).not_to eq('kanari')
      end

      it "will be numbereized" do
        expect(User.uniq_user_name('kanari')).to eq('kanari2')
      end

      it "will be counted-up" do
        expect(User.uniq_user_name('benri')).to eq('benri3')
      end

    end

  end

end
