# encoding: utf-8
require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each do |path|
  require path
end

[User, Room, Bot, AccessToken, Message, Membership].each do |model|
  model.delete_all
end

# User and primary access token
FactoryGirl.create :user,
  uid: 377137,
  screen_name: 'supermomonga',
  user_name: 'supermomonga',
  avatar_url: 'https://avatars.githubusercontent.com/u/377137?v=2'
FactoryGirl.create_list :user, 10

