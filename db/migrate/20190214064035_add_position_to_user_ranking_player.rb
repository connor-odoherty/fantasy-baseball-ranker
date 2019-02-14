class AddPositionToUserRankingPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :user_ranking_players, :position, :integer
  end
end
