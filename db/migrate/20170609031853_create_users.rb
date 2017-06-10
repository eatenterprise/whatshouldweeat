class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.belongs_to :round

      t.timestamps
    end
  end
end
