json.array!(@game_versions) do |game_version|
  json.extract! game_version, :id, :game_id, :version, :language
  json.url game_version_url(game_version, format: :json)
end
