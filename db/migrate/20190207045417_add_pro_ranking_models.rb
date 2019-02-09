class AddProRankingModels < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_ranking_sets do |t|
      t.string :publication_name
      t.string :ranking_name
      t.string :ranker_name
      t.string :url
      t.datetime :published_at
      t.string :slug
      t.index :slug, unique: true
    end

    create_table :pro_ranking_players do |t|
      t.integer :player_id
      t.integer :pro_ranking_set_id
      t.integer :ovr_rank
      t.text :notes
      t.float :adp
      t.integer :min_pick
      t.integer :max_pick
    end

    add_foreign_key :pro_ranking_players, :players, column: :player_id
    add_index :pro_ranking_players, :player_id

    add_foreign_key :pro_ranking_players, :pro_ranking_sets, column: :pro_ranking_set_id
    add_index :pro_ranking_players, :pro_ranking_set_id
  end
end
