# == Schema Information
#
# Table name: batting_projections
#
#  id                     :integer          not null, primary key
#  player_id              :integer
#  projection_system_id   :integer
#  games                  :float
#  plate_appearances      :float
#  at_bats                :float
#  hits                   :float
#  doubles                :float
#  triples                :float
#  home_runs              :float
#  runs                   :float
#  runs_batted_in         :float
#  batting_walks          :float
#  batting_strikeouts     :float
#  stolen_bases           :float
#  batting_average        :float
#  on_base_percentage     :float
#  slugging_percentage    :float
#  on_base_plus_slugging  :float
#  weighted_on_base       :float
#  wrc_plus               :float
#  wins_above_replacement :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_batting_projection_on_player_and_system      (player_id,projection_system_id) UNIQUE
#  index_batting_projections_on_player_id             (player_id)
#  index_batting_projections_on_projection_system_id  (projection_system_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (projection_system_id => projection_systems.id)
#

class BattingProjection < ApplicationRecord
  belongs_to :player
  belongs_to :projection_system
end
