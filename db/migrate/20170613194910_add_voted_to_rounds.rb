class AddVotedToRounds < ActiveRecord::Migration[5.1]
  def change
    add_column :rounds, :voted, :integer
  end
end
