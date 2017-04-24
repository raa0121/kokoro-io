# encoding: utf-8
require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each do |path|
  require path
end

[User, Room, Bot, AccessToken, Message, Membership].each do |model|
  model.delete_all
end

# User and primary access token
supermomonga = FactoryGirl.create :user,
  email: 'hi@supermomonga.com'
thinca = FactoryGirl.create :user,
  email: 'thinca@example.com'
linda_pp = FactoryGirl.create :user,
  email: 'rhysd@example.com'
ujihisa = FactoryGirl.create :user,
  email: 'ujihisa@example.com'

membership = thinca.private_rooms.first.memberships.create(memberable: supermomonga)
membership.invited!
membership.save

rooms = supermomonga.rooms
rooms.each do |r|
  30.times do |i|
    m = FactoryGirl.create :message,
                           room: r,
                           profile: supermomonga.profile,
                           content: "Message#{i} from id:#{supermomonga.profile.display_name} in #{r.display_name}",
                           published_at: Time.now - (i * 10).minutes
  end
end
