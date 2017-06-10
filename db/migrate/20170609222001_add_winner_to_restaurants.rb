class AddWinnerToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :winner, :boolean
  end
end
