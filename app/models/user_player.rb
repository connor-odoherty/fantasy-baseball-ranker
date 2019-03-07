# == Schema Information
#
# Table name: user_players
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  user_id    :integer
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tags       :integer
#
# Indexes
#
#  index_user_players_on_player_id              (player_id)
#  index_user_players_on_player_id_and_user_id  (player_id,user_id) UNIQUE
#  index_user_players_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (user_id => users.id)
#

class UserPlayer < ApplicationRecord
  has_many :user_ranking_players
  has_many :user_player_articles

  belongs_to :player
  belongs_to :user

  validates :player_id, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :user_player_articles, allow_destroy: true

  bitmask :tags,
          as: %i[
            draft_target value_pick sleeper_pick high_upside avoid_player health_risk
            young_potential risky_pick safe_pick regression_candidate bounceback_candidate
          ],
          zero_value: :none

  def self.acceptable_params
    [:notes, tags: [], user_player_articles_attributes: UserPlayerArticle.acceptable_params]
  end

  def tag_to_s(tag)
    case tag
    when :draft_target      then 'Target'
    when :value_pick        then 'Value'
    when :sleeper_pick      then 'Sleeper'
    when :high_upside       then 'Upside'
    when :avoid_player      then 'Avoid'
    when :health_risk       then 'Health'
    when :young_potential   then 'Youth'
    when :risky_pick        then 'Risky'
    when :safe_pick         then 'Safe'
    when :regression_candidate       then 'Regress'
    when :bounceback_candidate       then 'Rebound'
    else 'ERROR: Undefined tag'
    end
  end

  def self.selectable_tags
    %i[draft_target sleeper_pick avoid_player health_risk high_upside]
  end

  def active_tags
    tags.select { |t| UserPlayer.selectable_tags.include?(t) }
  end
end
