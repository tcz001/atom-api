class GameSkuAttributeSet < ActiveRecord::Base
  belongs_to :game_sku
  belongs_to :sku_attribute
end
