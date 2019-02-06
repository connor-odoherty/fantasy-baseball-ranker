# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  full_name       :string
#  current_team_id :integer
#  mlb_team_id     :integer
#  positions       :integer
#  slug            :string
#  dob             :datetime
#  mlb_id          :string
#  mlb_name        :string
#  mlb_pos         :string
#  mlb_team_short  :string
#  mlb_team_long   :string
#  mlb_depth       :string
#  bats            :string
#  throws          :string
#  birth_year      :integer
#  debut           :string
#  bp_id           :string
#  bref_id         :string
#  bref_name       :string
#  cbs_id          :string
#  cbs_name        :string
#  cbs_pos         :string
#  espn_id         :string
#  espn_name       :string
#  espn_pos        :string
#  fg_id           :string
#  fg_name         :string
#  fg_pos          :string
#  lahman_id       :string
#  nfbc_id         :string
#  nfbc_name       :string
#  nfbc_pos        :string
#  retro_id        :string
#  retro_name      :string
#  yahoo_id        :string
#  yahoo_name      :string
#  yahoo_pos       :string
#  ottoneu_id      :string
#  ottoneu_name    :string
#  ottoneu_pos     :string
#  rotowire_id     :string
#  rotowire_name   :string
#  rotowire_pos    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_players_on_current_team_id  (current_team_id)
#  index_players_on_mlb_team_id      (mlb_team_id)
#
# Foreign Keys
#
#  fk_rails_...  (current_team_id => pro_teams.id)
#  fk_rails_...  (mlb_team_id => pro_teams.id)
#

class Player < ApplicationRecord
  belongs_to :mlb_team, class_name: 'ProTeam'
  belongs_to :current_team, class_name: 'ProTeam'

  validates :full_name, presence: true
  # validates :team, presence: true
  validates :positions, presence: true
  # validates :mlb_team_id, presence: true
  validates :mlb_name, presence: true

  bitmask :positions,
          as: %i(
            catcher first_base second_base third_base short_stop infield
            left_field center_field right_field outfield utility
            starting_pitcher relief_pitcher closer middle_relief_pitcher pitcher
          ),
          zero_value: :none

  def display_name
    self.full_name
  end

  def display_team
    self.mlb_team.long_name
  end

  def display_age
    2019 - self.birth_year
  end

  def display_positions
    self.positions.map {|pos| pos.to_s}.join(' / ')
  end

  def fg_link
    "https://www.fangraphs.com/statss.aspx?playerid=#{self.fg_id}"
  end
end
