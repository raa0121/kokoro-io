FactoryGirl.define do
  factory :bot, class: Bot do
    user
    status :enabled
    sequence(:access_token) { Bot.generate_token }

    after(:create) do |bot|
      bot.profile = Profile.create(publisher: bot, screen_name: "bot#{bot.id}", display_name: "BotName#{bot.id}", available: true)
    end
  end
end
