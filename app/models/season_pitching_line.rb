# == Schema Information
#
# Table name: season_pitching_lines
#
#  id                                     :integer          not null, primary key
#  player_id                              :integer
#  data_season_id                         :integer
#  games                                  :float
#  games_started                          :float
#  wins                                   :float
#  losses                                 :float
#  saves                                  :float
#  innings_pitched                        :float
#  earned_run_average                     :float
#  walks_and_hits_per_ip                  :float
#  k_per_nine                             :float
#  bb_per_nine                            :float
#  hr_per_nine                            :float
#  k_rate                                 :float
#  bb_rate                                :float
#  k_minus_bb                             :float
#  sw_str_rate                            :float
#  babip                                  :float
#  left_on_base_rate                      :float
#  fielding_independent_pitching          :float
#  expected_fielding_independent_pitching :float
#  siera                                  :float
#  soft_contact_rate                      :float
#  medium_contact_rate                    :float
#  hard_contact_rate                      :float
#  wins_above_replacement                 :float
#  year                                   :integer
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_pitching_line_on_player_and_season       (player_id,data_season_id) UNIQUE
#  index_season_pitching_lines_on_data_season_id  (data_season_id)
#  index_season_pitching_lines_on_player_id       (player_id)
#  index_season_pitching_lines_on_year            (year)
#
# Foreign Keys
#
#  fk_rails_...  (data_season_id => data_seasons.id)
#  fk_rails_...  (player_id => players.id)
#

class SeasonPitchingLine < ApplicationRecord
  include BuildPlayerStats

  belongs_to :player
  belongs_to :data_season

  validates :player_id, :data_season_id, presence: true

  def stat_fields
    %i[games
       games_started
       wins
       losses
       saves
       innings_pitched
       earned_run_average
       walks_and_hits_per_ip
       k_per_nine
       bb_per_nine
       hr_per_nine
       k_rate
       bb_rate
       k_minus_bb
       sw_str_rate
       babip
       left_on_base_rate
       fielding_independent_pitching
       expected_fielding_independent_pitching
       siera
       soft_contact_rate
       medium_contact_rate
       hard_contact_rate
       wins_above_replacement]
  end
end
