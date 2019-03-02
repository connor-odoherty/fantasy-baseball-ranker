# == Schema Information
#
# Table name: user_ranking_players
#
#  id                  :integer          not null, primary key
#  user_player_id      :integer
#  user_ranking_set_id :integer
#  ovr_rank            :integer
#  elo_score           :integer
#  position            :integer
#
# Indexes
#
#  index_unique_on_user_player_and_user_ranking_set   (user_player_id,user_ranking_set_id) UNIQUE
#  index_user_ranking_players_on_elo_score            (elo_score)
#  index_user_ranking_players_on_ovr_rank             (ovr_rank)
#  index_user_ranking_players_on_user_player_id       (user_player_id)
#  index_user_ranking_players_on_user_ranking_set_id  (user_ranking_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_player_id => user_players.id)
#  fk_rails_...  (user_ranking_set_id => user_ranking_sets.id) ON DELETE => cascade
#

class UserRankingPlayer < ApplicationRecord
  # include RankedModel

  belongs_to :user_ranking_set
  belongs_to :user_player

  # TODO: See if there was a sorting issue offsetting from 1
  # acts_as_list scope: :user_ranking_set
  #
  # ranks :ovr_rank
  # ranks :elo_score

  validates :user_player_id, presence: true
  validates :user_ranking_set_id, presence: true
  validates :ovr_rank, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :user_player
end
