class CreateUserRankingModels < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :autocomplete_search_field, :string

    create_table :user_players do |t|
      t.integer :player_id
      t.integer :user_id
      t.text :notes
      t.timestamps
    end

    add_foreign_key :user_players, :players, column: :player_id
    add_index :user_players, :player_id

    add_foreign_key :user_players, :users, column: :user_id
    add_index :user_players, :user_id

    create_table :user_player_articles do |t|
      t.integer :user_player_id
      t.string :title
      t.string :publication
      t.string :article_url
      t.text :notes
      t.timestamps
    end

    add_foreign_key :user_player_articles, :user_players, column: :user_player_id
    add_index :user_player_articles, :user_player_id

    create_table :user_ranking_sets do |t|
      t.integer :user_id
      t.string :ranking_name
      t.timestamps
    end

    create_table :user_ranking_players do |t|
      t.integer :user_player_id
      t.integer :user_ranking_set_id
      t.integer :ovr_rank
      t.integer :elo_score
      t.integer :position
    end

    # remove_foreign_key :user_ranking_players, column: :player_id
    # remove_index :user_ranking_players, :player_id

    add_foreign_key :user_ranking_sets, :users, column: :user_id
    add_index :user_ranking_sets, :user_id

    add_foreign_key :user_ranking_players, :user_players, column: :user_player_id
    add_index :user_ranking_players, :user_player_id

    add_foreign_key :user_ranking_players, :user_ranking_sets, column: :user_ranking_set_id, on_delete: :cascade
    add_index :user_ranking_players, :user_ranking_set_id

    add_index :user_ranking_players, :ovr_rank
    add_index :user_ranking_players, :elo_score
  end
end
