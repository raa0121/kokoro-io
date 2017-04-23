FactoryGirl.define do
  factory :orange, class: Bot do
    user
    display_name 'orange-bot'
    screen_name 'orange'
    access_token 'ORANGE'
    status :envabled
  end
end
