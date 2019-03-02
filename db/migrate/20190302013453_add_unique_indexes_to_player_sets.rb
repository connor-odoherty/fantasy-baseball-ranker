class AddUniqueIndexesToPlayerSets < ActiveRecord::Migration[5.0]
  def change
    add_index :user_ranking_players, [:user_player_id, :user_ranking_set_id], unique: true, name: 'index_unique_on_user_player_and_user_ranking_set'
    add_index :pro_ranking_players, [:player_id, :pro_ranking_set_id], unique: true, name: 'index_unique_on_player_and_pro_ranking_set'
    add_index :user_players, [:player_id, :user_id], unique: true
    add_index :players, :fg_id, unique: true
  end
end
