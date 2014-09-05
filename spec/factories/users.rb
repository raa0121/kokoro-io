FactoryGirl.define do
  factory :user do
    provider 'github'
    uid 'test'
    screen_name 'name'
    user_name 'user'
    avatar_url 'htt://hi.com/hi.jpg'
  end
end
