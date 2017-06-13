class RemoveVotedFromRounds < ActiveRecord::Migration[5.1]
  def change
    remove_column :rounds, :voted, :integer
  end
end
