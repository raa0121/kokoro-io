require 'rails_helper'

RSpec.describe ProfilePolicy do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { Profile.find_by(publisher: user) }

  context "for a publisher" do
    subject { ProfilePolicy.new(user, profile) }
    it { should authorize(:show) }
    it { should authorize(:update) }
  end

  context 'for a not publisher' do
    let(:other) { FactoryGirl.create(:user) }
    subject { ProfilePolicy.new(other, profile) }
    it { should authorize(:show) }
    it { should_not authorize(:update) }
  end

  context 'unavailable user' do
    before do
      profile.update_attribute(:available, false)
    end
    subject { ProfilePolicy.new(user, profile) }
    it { should_not authorize(:show) }
  end
end
