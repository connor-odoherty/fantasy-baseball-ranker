class AddConfigurationColumnsToUserRankingSet < ActiveRecord::Migration[5.0]
  def change
    add_column :user_ranking_sets, :elo_k_value, :integer, default: 24
    add_column :user_ranking_sets, :elo_spread, :integer, default: 1
    add_column :user_ranking_sets, :elo_seed, :integer, default: 2500
    add_column :user_ranking_sets, :elo_init_strategy, :integer, default: 0
    add_column :user_ranking_sets, :elo_score_strategy, :integer, default: 0
    add_column :user_ranking_sets, :show_adp_strategy, :integer, default: 0
  end
end
