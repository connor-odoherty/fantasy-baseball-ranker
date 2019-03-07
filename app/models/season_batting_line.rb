# == Schema Information
#
# Table name: season_batting_lines
#
#  id                     :integer          not null, primary key
#  player_id              :integer
#  data_season_id         :integer
#  games                  :float
#  plate_appearances      :float
#  at_bats                :float
#  runs                   :float
#  runs_batted_in         :float
#  home_runs              :float
#  stolen_bases           :float
#  batting_average        :float
#  babip                  :float
#  on_base_percentage     :float
#  slugging_percentage    :float
#  on_base_plus_slugging  :float
#  iso                    :float
#  k_rate                 :float
#  bb_rate                :float
#  sw_str_rate            :float
#  weighted_on_base       :float
#  wrc_plus               :float
#  line_drive_rate        :float
#  ground_ball_rate       :float
#  fly_ball_rate          :float
#  hr_to_fly_ball_rate    :float
#  infield_fly_ball_rate  :float
#  pull_rate              :float
#  center_rate            :float
#  oppo_rate              :float
#  soft_contact_rate      :float
#  medium_contact_rate    :float
#  hard_contact_rate      :float
#  wins_above_replacement :float
#  year                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_batting_line_on_player_and_season       (player_id,data_season_id) UNIQUE
#  index_season_batting_lines_on_data_season_id  (data_season_id)
#  index_season_batting_lines_on_player_id       (player_id)
#  index_season_batting_lines_on_year            (year)
#
# Foreign Keys
#
#  fk_rails_...  (data_season_id => data_seasons.id)
#  fk_rails_...  (player_id => players.id)
#

class SeasonBattingLine < ApplicationRecord
  include BuildPlayerStats

  belongs_to :player
  belongs_to :data_season

  validates :player_id, :data_season_id, presence: true

  def stat_fields
    %i[games
       plate_appearances
       at_bats
       runs
       runs_batted_in
       home_runs
       stolen_bases
       batting_average
       babip
       on_base_percentage
       slugging_percentage
       on_base_plus_slugging
       iso
       k_rate
       bb_rate
       sw_str_rate
       weighted_on_base
       wrc_plus
       line_drive_rate
       ground_ball_rate
       fly_ball_rate
       hr_to_fly_ball_rate
       infield_fly_ball_rate
       pull_rate
       center_rate
       oppo_rate
       soft_contact_rate
       medium_contact_rate
       hard_contact_rate
       wins_above_replacement]
  end
end
