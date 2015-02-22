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
FactoryGirl.create :user,
  uid: 20474,
  screen_name: 'thinca',
  user_name: 'Thinca',
  avatar_url: 'https://avatars.githubusercontent.com/u/20474?v=2'
FactoryGirl.create :user,
  uid: 823277,
  screen_name: 'rhysd',
  user_name: 'Linda_pp',
  avatar_url: 'https://avatars.githubusercontent.com/u/823277?v=2'
FactoryGirl.create :user,
  uid: 11504,
  screen_name: 'ujihisa',
  user_name: 'ujihisa',
  avatar_url: 'https://avatars.githubusercontent.com/u/11504?v=2'

