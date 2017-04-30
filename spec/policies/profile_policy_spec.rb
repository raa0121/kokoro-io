require 'rails_helper'

RSpec.describe ProfilePolicy do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { Profile.find_by(publisher: user) }
  subject { ProfilePolicy.new(user, profile) }

  context "for a login user" do
    it { should authorize(:show) }
  end

end
