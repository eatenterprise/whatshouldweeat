class Changevoteddefaultinrounds < ActiveRecord::Migration[5.1]
  def change
    change_column :rounds, :finished_voting_count, :integer, default: 0
  end
end
