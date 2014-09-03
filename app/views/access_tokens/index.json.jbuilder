json.array!(@access_tokens) do |access_token|
  json.extract! access_token, :id, :user_id, :name, :token
  json.url access_token_url(access_token, format: :json)
end
