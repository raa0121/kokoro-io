FactoryGirl.define do

  factory :room do
    sequence(:room_name) {|n| "room-#{n}" }
    sequence(:screen_name) {|n| "Room ##{n}" }
    sequence(:private) {|n| n % 2 == 0 }
    sequence(:description) {|n| "Description of room ##{n}" }
  end

end

