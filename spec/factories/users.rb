FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:password) { |n| "changeme" }
    sequence(:password_confirmation) { |n| "changeme" }

    after(:create) do |user|
      rooms = create_list :room, 4, users: [user]
      rooms.map(&:memberships).flatten.map(&:administrator!)
      create :access_token, user: user, essential: true
    end
  end
end
