class ChangeGameIdToGameSkuIdOnAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :game_sku, index: true, foreign_key: true
    lease_orders = LeaseOrder.all
    lease_orders.each { |lo|
      lo.accounts.each { |a|
        a.update(game_sku: GameSku.where(game_id: a.game_id).first)
        a.update(game_id: nil)
      }
    }
    remove_reference :accounts, :game, index: true, foreign_key: true
    remove_reference :games, :game_version, index: true, foreign_key: true
  end
end
