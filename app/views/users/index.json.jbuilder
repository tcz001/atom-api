json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :mobile
  json.url user_url(user, format: :json)
end
