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
  belongs_to :user
  has_many :user_ranking_players, -> { includes(player: [:mlb_team]).order(position: :asc) }, dependent: :destroy
  belongs_to :user

  default_scope -> { order(created_at: :asc) }

  validates :user_id, presence: true
  validates :ranking_name, presence: true


  def display_name
    self.ranking_name
  end
end
