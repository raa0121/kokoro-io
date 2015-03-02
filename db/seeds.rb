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
  uid: 377137,
  screen_name: 'supermomonga',
  user_name: 'supermomonga',
  avatar_url: 'https://avatars.githubusercontent.com/u/377137?v=2'
thinca = FactoryGirl.create :user,
  uid: 20474,
  screen_name: 'thinca',
  user_name: 'Thinca',
  avatar_url: 'https://avatars.githubusercontent.com/u/20474?v=2'
linda_pp = FactoryGirl.create :user,
  uid: 823277,
  screen_name: 'rhysd',
  user_name: 'Linda_pp',
  avatar_url: 'https://avatars.githubusercontent.com/u/823277?v=2'
ujihisa = FactoryGirl.create :user,
  uid: 11504,
  screen_name: 'ujihisa',
  user_name: 'ujihisa',
  avatar_url: 'https://avatars.githubusercontent.com/u/11504?v=2'

membership = thinca.private_rooms.first.memberships.create(memberable: supermomonga)
membership.invited!
membership.save

rooms = supermomonga.rooms
rooms.each do |r|
  30.times do |i|
    m = FactoryGirl.create :message,
                           room: r,
                           publisher: supermomonga,
                           content: "Message#{i} from #{supermomonga.user_name} in #{r.room_name}",
                           published_at: Time.now - (i * 10).minutes
  end
end
