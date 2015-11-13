require 'rest-client'
require 'json'

p "================== admin ================="
response = RestClient.post 'http://localhost:3000/oauth/token', {
  grant_type: 'password',
  username:'admin',
  password:'12345678'
}
p response
token = JSON.parse(response)["access_token"]
p "Bearer #{token}"
response = RestClient.get 'http://localhost:3000/api/users/me.json', {
  Authorization: "Bearer #{token}"
}
p response

p "================== test user ================="
response = RestClient.post 'http://localhost:3000/oauth/token', {
  grant_type: 'password',
  username:'18611000000',
  password:'12345678'
}
p response
token = JSON.parse(response)["access_token"]
p "Bearer #{token}"
response = RestClient.get 'http://localhost:3000/api/users/me.json', {
  Authorization: "Bearer #{token}"
}
p response
