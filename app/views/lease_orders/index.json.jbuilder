json.array!(@lease_orders) do |lease_order|
  json.extract! lease_order, :id, :games_id, :game_versions_id, :third_partys_id, :irb
  json.url lease_order_url(lease_order, format: :json)
end
