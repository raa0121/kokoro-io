json.array!(@rooms) do |room|
  json.extract! room, :id, :room_name, :screen_name, :private
  json.url room_url(room, format: :json)
end
