# frozen_string_literal: true
# == Schema Information
#
# Table name: players
#
#  id                        :integer          not null, primary key
#  full_name                 :string
#  current_team_id           :integer
#  mlb_team_id               :integer
#  positions                 :integer
#  slug                      :string
#  dob                       :datetime
#  mlb_id                    :string
#  mlb_name                  :string
#  mlb_pos                   :string
#  mlb_team_short            :string
#  mlb_team_long             :string
#  mlb_depth                 :string
#  bats                      :string
#  throws                    :string
#  birth_year                :integer
#  debut                     :string
#  bp_id                     :string
#  bref_id                   :string
#  bref_name                 :string
#  cbs_id                    :string
#  cbs_name                  :string
#  cbs_pos                   :string
#  espn_id                   :string
#  espn_name                 :string
#  espn_pos                  :string
#  fg_id                     :string
#  fg_name                   :string
#  fg_pos                    :string
#  lahman_id                 :string
#  nfbc_id                   :string
#  nfbc_name                 :string
#  nfbc_pos                  :string
#  retro_id                  :string
#  retro_name                :string
#  yahoo_id                  :string
#  yahoo_name                :string
#  yahoo_pos                 :string
#  ottoneu_id                :string
#  ottoneu_name              :string
#  ottoneu_pos               :string
#  rotowire_id               :string
#  rotowire_name             :string
#  rotowire_pos              :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  autocomplete_search_field :string
#  adp                       :float
#
# Indexes
#
#  index_players_on_current_team_id  (current_team_id)
#  index_players_on_fg_id            (fg_id) UNIQUE
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
  has_many :user_players
  has_many :batting_projections
  has_many :pitching_projections
  has_many :season_batting_lines
  has_many :season_pitching_lines

  before_save :build_autocomplete_search_field

  validates :full_name, presence: true
  # validates :team, presence: true
  validates :positions, presence: true
  # validates :mlb_team_id, presence: true
  validates :mlb_name, presence: true

  bitmask :positions,
          as: %i[
            catcher first_base second_base third_base short_stop infield
            left_field center_field right_field outfield utility
            starting_pitcher relief_pitcher closer middle_relief_pitcher pitcher
          ],
          zero_value: :none

  def self.acceptable_params
    [:full_name, :dob, :mlb_team_id, :mlb_id, :mlb_name, :fg_id, positions: []]
  end

  def display_name
    full_name
  end

  def display_team
    mlb_team.short_name
  end

  def display_age
    2019 - birth_year
  end

  def position_to_s(position)
    case position
    when :catcher          then 'C'
    when :first_base       then '1B'
    when :second_base      then '2B'
    when :third_base       then '3B'
    when :short_stop       then 'SS'
    when :outfield         then 'OF'
    when :starting_pitcher then 'SP'
    when :relief_pitcher   then 'RP'
    else 'ERROR: Undefined position'
    end
  end

  def positions_to_display
    %i[catcher first_base second_base third_base short_stop outfield starting_pitcher relief_pitcher]
  end

  def self.selectable_postions
    %i[catcher first_base second_base third_base short_stop outfield starting_pitcher relief_pitcher]
  end

  def display_positions
    position_list = positions_to_display.select { |pos| positions.include? pos }.map { |pos| position_to_s(pos) }
    if position_list.length > 3
      'SUPER'
    elsif position_list.length == 3
      position_list.join('/')
    else
      position_list.join(' / ')
    end
  end

  def is_pitcher?
    has_any_positions?(:starting_pitcher, :relief_pitcher)
  end

  def is_batter?
    has_any_positions?(:catcher, :first_base, :second_base, :third_base, :short_stop, :outfield)
  end

  def fg_link
    "https://www.fangraphs.com/statss.aspx?playerid=#{fg_id}"
  end

  def build_autocomplete_search_field
    fields = []

    fields << full_name
    fields << yahoo_name
    fields << mlb_team&.long_name

    self.autocomplete_search_field = fields.select(&:present?).join(' ')
  end
end
