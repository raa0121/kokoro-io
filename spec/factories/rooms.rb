FactoryGirl.define do

  factory :room do
    sequence(:screen_name) {|n| "room-#{n}" }
    sequence(:room_name) {|n| "%s Room ##{n}" }
    sequence(:description) {|n| "Description of room ##{n}" }
    sequence(:private) {|n| n % 2 == 0}

    trait :private do
      private true
    end

    trait :public do
      private false
    end
  end
end
