class SetDefaultDepositToGame < ActiveRecord::Migration
  def up
    Game.update_all({deposit: 150})
  end
end
