FactoryGirl.define do

  factory :user do
    provider 'github'
    sequence(:uid) {|n| n }
    sequence(:user_name) {|n| "User #{n}" }
    sequence(:screen_name) {|n| "user-#{n}" }
    sequence(:avatar_url) {|n| "https://avatar.com/#{n}" }

    after(:create) do |user|
      rooms = create_list :room, 4, users: [user]
      rooms.map(&:memberships).flatten.map(&:administer!)
      create :access_token, user: user, essential: true
    end
  end
end
