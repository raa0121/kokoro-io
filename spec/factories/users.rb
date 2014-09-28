FactoryGirl.define do

  factory :user do
    provider 'github'
    sequence(:uid) {|n| n }
    sequence(:screen_name) {|n| "User #{n}" }
    sequence(:user_name) {|n| "user-#{n}" }
    avatar_url 'https://avatars.githubusercontent.com/u/377137?v=2'

    after(:create) do |user|
      create :access_token, user: user, essential: true
    end
  end

  factory :momonga do
    provider 'github'
    uid 277137
    screen_name 'supermomonga'
    user_name 'supermomonga'
    avatar_url 'https://avatars.githubusercontent.com/u/377137?v=2'

    after(:create) do |u|
      create :primary_access_token, user: u
    end
  end

end
