# == Schema Information
#
# Table name: players
#
#  id            :integer          not null, primary key
#  full_name     :string
#  team          :string
#  position      :string
#  slug          :string
#  dob           :datetime
#  mlb_id        :string
#  mlb_name      :string
#  mlb_pos       :string
#  mlb_team      :string
#  mlb_team_long :string
#  mlb_depth     :string
#  bats          :string
#  throws        :string
#  birth_year    :integer
#  debut         :string
#  bp_id         :string
#  bref_id       :string
#  bref_name     :string
#  cbs_id        :string
#  cbs_name      :string
#  cbs_pos       :string
#  espn_id       :string
#  espn_name     :string
#  espn_pos      :string
#  fg_id         :string
#  fg_name       :string
#  fg_pos        :string
#  lahman_id     :string
#  nfbc_id       :string
#  nfbc_name     :string
#  nfbc_pos      :string
#  retro_id      :string
#  retro_name    :string
#  yahoo_id      :string
#  yahoo_name    :string
#  yahoo_pos     :string
#  ottoneu_id    :string
#  ottoneu_name  :string
#  ottoneu_pos   :string
#  rotowire_id   :string
#  rotowire_name :string
#  rotowire_pos  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Player < ApplicationRecord
  validates :full_name, presence: true
  validates :team, presence: true
  validates :position, presence: true
  validates :mlb_id, presence: true
  validates :mlb_name, presence: true
  validates :mlb_team, presence: true

  def display_name
    self.full_name
  end

  def display_team
    self.team
  end

  def display_age
    2019 - self.birth_year
  end

  def display_positons
    self.position
  end

  def fg_link
    "https://www.fangraphs.com/statss.aspx?playerid=#{self.fg_id}"
  end
end
