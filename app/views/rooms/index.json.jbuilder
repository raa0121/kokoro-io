json.array!(@rooms) do |room|
  json.extract! room, :id, :display_name, :screen_name, :private
  json.url room_url(room, format: :json)
end
