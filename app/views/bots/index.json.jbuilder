json.array!(@bots) do |bot|
  json.extract! bot, :id, :user_id, :access_token, :display_name, :screen_name, :status
  json.url bot_url(bot, format: :json)
end
