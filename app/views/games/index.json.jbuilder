json.array!(@games) do |game|
  json.extract! game, :id, :name, :isHot, :gameType, :nickName, :developer, :minplayer, :maxplayer
  json.url game_url(game, format: :json)
end
