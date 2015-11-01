json.array!(@accounts) do |account|
  json.extract! account, :id, :game_version_id, :user_id, :account, :password, :status, :is_valid
  json.url account_url(account, format: :json)
end
