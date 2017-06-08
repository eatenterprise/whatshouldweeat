class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :votes, default: 0
      t.belongs_to :round

      t.timestamps
    end
  end
end
