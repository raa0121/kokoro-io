json.extract! profile, :id, :display_name, :screen_name, :avatar_id, :available, :created_at, :updated_at
json.url profile_url(profile, format: :json)
