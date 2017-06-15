class AddPhoneToRounds < ActiveRecord::Migration[5.1]
  def change
    add_column :rounds, :phone, :string
  end
end
