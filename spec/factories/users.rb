FactoryGirl.define do

  factory :user do
    provider 'github'
    sequence(:uid) {|n| n }
    sequence(:screen_name) {|n| "User #{n}" }
    sequence(:user_name) {|n| "user-#{n}" }
    avatar_url 'https://avatars.githubusercontent.com/u/377137?v=2'

    factory :momonga do
      uid 277237
      screen_name 'supermomonga'
      user_name 'supermomonga'
      avatar_url 'https://avatars.githubusercontent.com/u/377137?v=2'
    end

    after(:create) do |user|
      create :access_token, user: user, essential: true
    end
  end

end
