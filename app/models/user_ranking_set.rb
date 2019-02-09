# == Schema Information
#
# Table name: user_ranking_sets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  ranking_name  :string
#  position_rule :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserRankingSet < ApplicationRecord
  has_many :user_ranking_players

  validates :user_id, presence: true
  validates :ranking_name, presence: true
end
