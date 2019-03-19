# == Schema Information
#
# Table name: user_ranking_sets
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  ranking_name       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  elo_k_value        :integer          default(24)
#  elo_spread         :integer          default(1)
#  elo_seed           :integer          default(2500)
#  elo_init_strategy  :integer          default(0)
#  elo_score_strategy :integer          default(0)
#  show_adp_strategy  :integer          default(0)
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
  has_many :user_ranking_players, dependent: :destroy

  belongs_to :user

  default_scope -> { order(updated_at: :desc) }

  validates :user_id, presence: true
  validates :ranking_name, presence: true
  validate :no_duplicate_positions

  enum elo_init_strategy: { linear_decline: 0, all_equal: 1 }
  enum elo_score_strategy: { elo_scoring: 0, swap_scoring: 1 }
  enum show_adp_strategy: { show_adp_at_all_times: 0, hide_adp_on_edit: 1 }

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

  def self.elo_init_strategy_options
    [['Linear decline from seed value', :linear_decline], ['All equal seed value', :all_equal]]
  end

  def self.elo_score_strategy_options
    [['Use ELO scoring', :elo_scoring], ['Use swap scoring', :swap_scoring]]
  end

  def reset_elo_scores
    if self.linear_decline?
      reset_elo_using_linear_decline
    elsif self.all_equal?
      reset_elo_using_all_equal
    end
  end

  private

  def reset_elo_using_linear_decline
    self.user_ranking_players.order(ovr_rank: :asc).each_with_index do |user_ranking_player, index|
      user_ranking_player.update!(elo_score: (self.elo_seed - index))
    end
  end

  def reset_elo_using_all_equal
    self.user_ranking_players.update_all(elo_score: self.elo_seed)
  end
end
