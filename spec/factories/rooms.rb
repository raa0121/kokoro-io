FactoryGirl.define do

  factory :room do
    sequence(:screen_name) {|n| "room-#{n}" }
    sequence(:room_name) {|n| "%s Room ##{n}" % ( n % 2 == 0 ? "Private" : "Public" ) }
    sequence(:private) {|n| n % 2 == 0 }
    sequence(:description) {|n| "Description of room ##{n}" }
  end

end

