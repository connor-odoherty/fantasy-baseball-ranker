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
#
# Indexes
#
#  index_user_players_on_player_id  (player_id)
#  index_user_players_on_user_id    (user_id)
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

  def self.acceptable_params
    [:notes, user_player_articles_attributes: UserPlayerArticle.acceptable_params]
  end
end
