# frozen_string_literal: true

# == Schema Information
#
# Table name: pro_teams
#
#  id         :integer          not null, primary key
#  slug       :string
#  short_name :string
#  long_name  :string
#

class ProTeam < ApplicationRecord
  has_many :players, class_name: 'Player', foreign_key: 'current_team_id'
  has_many :mlb_players, class_name: 'Player', foreign_key: 'mlb_team_id'
end
