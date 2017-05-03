require 'rails_helper'

RSpec.describe Profile, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile }

  describe "ユーザーが紐付いている時" do

    it "user は User モデル" do
      expect(profile.user.class).to eq(User)
    end

    it "bot は nil" do
      expect(profile.bot).to eq(nil)
    end

    it "publisher は User モデル" do
      expect(profile.publisher.class).to eq(User)
    end

    it "screen_name は nil ではない" do
      expect(profile.screen_name).not_to eq(nil)
    end

    it "archived? が false になる" do
      expect(profile.archived?).to eq(false)
    end

  end

  describe "ユーザーを削除した時" do

    before do
      user.destroy
    end

    it "プロフィールのみが残る" do
      expect(profile.user).to eq(nil)
    end

    it "screen_name が nil になる" do
      expect(profile.screen_name).to eq(nil)
    end

    it "archived? が true になる" do
      expect(profile.archived?).to eq(true)
    end

  end

end
