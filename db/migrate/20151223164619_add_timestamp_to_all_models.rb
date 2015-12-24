class AddTimestampToAllModels < ActiveRecord::Migration
  CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'
  UPDATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'
  def up
    change_column :accounts,:created_at, CREATE_TIMESTAMP
    change_column :accounts,:updated_at, UPDATE_TIMESTAMP
    change_column :admins,:created_at, CREATE_TIMESTAMP
    change_column :admins,:updated_at, UPDATE_TIMESTAMP
    change_column :charges,:created_at, CREATE_TIMESTAMP
    change_column :charges,:updated_at, UPDATE_TIMESTAMP
    change_column :game_types,:created_at, CREATE_TIMESTAMP
    change_column :game_types,:updated_at, UPDATE_TIMESTAMP
    change_column :game_versions,:created_at, CREATE_TIMESTAMP
    change_column :game_versions,:updated_at, UPDATE_TIMESTAMP
    change_column :games,:created_at, CREATE_TIMESTAMP
    change_column :games,:updated_at, UPDATE_TIMESTAMP
    change_column :images,:created_at, CREATE_TIMESTAMP
    change_column :images,:updated_at, UPDATE_TIMESTAMP
    change_column :lease_orders,:created_at, CREATE_TIMESTAMP
    change_column :lease_orders,:updated_at, UPDATE_TIMESTAMP
    change_column :third_parties,:created_at, CREATE_TIMESTAMP
    change_column :third_parties,:updated_at, UPDATE_TIMESTAMP
    change_column :users,:created_at, CREATE_TIMESTAMP
    change_column :users,:updated_at, UPDATE_TIMESTAMP
  end
end
