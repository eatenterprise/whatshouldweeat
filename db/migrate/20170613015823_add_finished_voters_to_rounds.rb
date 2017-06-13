class AddFinishedVotersToRounds < ActiveRecord::Migration[5.1]
  def change
    add_column :rounds, :finished_voting_count, :integer
  end
end
