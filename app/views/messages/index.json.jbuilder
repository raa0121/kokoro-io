json.array!(@messages) do |message|
  json.extract! message, :id, :room_id, :publisher_id, :content, :published_at
  json.url message_url(message, format: :json)
end
