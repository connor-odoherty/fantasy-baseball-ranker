# == Schema Information
#
# Table name: pitching_projections
#
#  id                            :integer          not null, primary key
#  player_id                     :integer
#  projection_system_id          :integer
#  games                         :float
#  games_started                 :float
#  wins                          :float
#  losses                        :float
#  saves                         :float
#  earned_run_average            :float
#  innings_pitched               :float
#  hits_allowed                  :float
#  home_runs_allowed             :float
#  earned_runs_allowed           :float
#  pitching_walks                :float
#  pitching_strikeouts           :float
#  walks_and_hits_per_ip         :float
#  k_per_nine                    :float
#  bb_per_nine                   :float
#  fielding_independent_pitching :float
#  wins_above_replacement        :float
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_pitching_projection_on_player_and_system      (player_id,projection_system_id) UNIQUE
#  index_pitching_projections_on_player_id             (player_id)
#  index_pitching_projections_on_projection_system_id  (projection_system_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (projection_system_id => projection_systems.id)
#

class PitchingProjection < ApplicationRecord
  belongs_to :player
  belongs_to :projection_system
end
