require 'test_helper'

class GameSkuTest < ActiveSupport::TestCase
  test "should be able to build a game sku" do
    a1 = SkuAttribute.create(name: 'option 1', option_value: 'a')
    SkuAttribute.create(name: 'option 1', option_value: 'b')
    a2 = SkuAttribute.create(name: 'option 2', option_value: 'a')
    SkuAttribute.create(name: 'option 2', option_value: 'b')
    game_sku = GameSku.create(price: 11.00, game: Game.create)
    game_sku.sku_attributes = [a1, a2]
    assert game_sku.sku_attributes.present?
    assert game_sku.sku_attributes.include? a1
    assert game_sku.sku_attributes.include? a2
  end
end
