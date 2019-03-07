# == Schema Information
#
# Table name: user_ranking_sets
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  ranking_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_ranking_sets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UserRankingSet < ApplicationRecord
  belongs_to :user
  has_many :user_ranking_players, lambda {
                                    includes(user_player:
                                                    [:user_player_articles,
                                                     player: [:mlb_team,
                                                              :season_batting_lines,
                                                              :season_pitching_lines,
                                                              batting_projections: [:projection_system],
                                                              pitching_projections: [:projection_system]]]).order(ovr_rank: :asc).limit(100)
                                  }, dependent: :destroy
  belongs_to :user

  default_scope -> { order(created_at: :asc) }

  validates :user_id, presence: true
  validates :ranking_name, presence: true
  validate :no_duplicate_positions

  validate do |user_ranking_set|
    # TODO: User ranking players is nil at this point
    return true unless user_ranking_set.user_ranking_players

    user_ranking_set.user_ranking_players.each do |player|
      next if player.valid?

      player.errors.full_messages.each do |msg|
        # you can customize the error message here:
        user_ranking_set.errors.add(:user_ranking_player, "#{player.user_player.player.display_name} #{msg}")
      end
    end
  end

  accepts_nested_attributes_for :user_ranking_players

  def display_name
    ranking_name
  end

  def no_duplicate_positions
    positions_list = user_ranking_players.pluck(:position)
    duplicate = positions_list.detect { |e| positions_list.count(e) > 1 }
    errors.add(:user_ranking_set, "has duplicates with position #{duplicate}") if duplicate.present?
  end
end
