class CreateUserRankingModels < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ranking_sets do |t|
      t.integer :user_id
      t.string :ranking_name
      t.integer :position_rule
      t.timestamps
    end

    create_table :user_ranking_players do |t|
      t.integer :player_id
      t.integer :user_ranking_set_id
      t.integer :ovr_rank
      t.integer :elo_score
      t.integer :position
      t.text :notes
    end

    add_foreign_key :user_ranking_players, :players, column: :player_id
    add_index :user_ranking_players, :player_id

    add_foreign_key :user_ranking_players, :user_ranking_sets, column: :user_ranking_set_id, on_delete: :cascade
    add_index :user_ranking_players, :user_ranking_set_id

    add_index :user_ranking_players, :ovr_rank
    add_index :user_ranking_players, :elo_score
  end
end

