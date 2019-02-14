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
  validate :no_duplicate_positions

  accepts_nested_attributes_for :user_ranking_players

  def display_name
    self.ranking_name
  end

  def no_duplicate_positions
    positions_list = self.user_ranking_players.pluck(:position)
    duplicate = positions_list.detect{ |e| positions_list.count(e) > 1 }
    self.errors.add(:user_ranking_set, "has duplicates with position #{duplicate}") if duplicate.present?
  end
end
