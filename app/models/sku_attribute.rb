class SkuAttribute < ActiveRecord::Base
  has_and_belongs_to_many :game_skus, join_table: 'game_sku_attribute_sets'
end
