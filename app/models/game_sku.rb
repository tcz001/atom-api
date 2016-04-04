class GameSku < ActiveRecord::Base
  belongs_to :game
  has_and_belongs_to_many :sku_attributes, join_table: 'game_sku_attribute_sets'

  scope :published, -> { where(is_valid: true) }
end
