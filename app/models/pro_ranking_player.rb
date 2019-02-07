# frozen_string_literal: true

# == Schema Information
#
# Table name: pro_ranking_players
#
#  id                 :integer          not null, primary key
#  player_id          :integer
#  pro_ranking_set_id :integer
#  ovr_rank           :integer
#  notes              :text
#  adp                :float
#  min_pick           :integer
#  max_pick           :integer
#
# Indexes
#
#  index_pro_ranking_players_on_player_id           (player_id)
#  index_pro_ranking_players_on_pro_ranking_set_id  (pro_ranking_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (pro_ranking_set_id => pro_ranking_sets.id)
#

class ProRankingPlayer < ApplicationRecord
  include RankedModel

  belongs_to :pro_ranking_set
  belongs_to :player

  ranks :ovr_rank

  validates :player_id, presence: true
  validates :pro_ranking_set_id, presence: true
  validates :ovr_rank, presence: true
end
