# == Schema Information
#
# Table name: user_ranking_players
#
#  id                  :integer          not null, primary key
#  player_id           :integer
#  user_ranking_set_id :integer
#  ovr_rank            :integer
#  elo_score           :integer
#  notes               :text
#  position            :integer
#
# Indexes
#
#  index_user_ranking_players_on_elo_score            (elo_score)
#  index_user_ranking_players_on_ovr_rank             (ovr_rank)
#  index_user_ranking_players_on_player_id            (player_id)
#  index_user_ranking_players_on_user_ranking_set_id  (user_ranking_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (user_ranking_set_id => user_ranking_sets.id)
#

class UserRankingPlayer < ApplicationRecord
  include RankedModel

  belongs_to :user_ranking_set
  belongs_to :player

  acts_as_list scope: :user_ranking_set

  ranks :ovr_rank
  ranks :elo_score

  validates :player_id, presence: true
  validates :user_ranking_set_id, presence: true
  validates :ovr_rank, presence: true

  delegate :display_name, :display_team, :display_age, :display_positions, :fg_link, to: :player
end
