# == Schema Information
#
# Table name: user_player_articles
#
#  id             :integer          not null, primary key
#  user_player_id :integer
#  title          :string
#  publication    :string
#  article_url    :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_user_player_articles_on_user_player_id  (user_player_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_player_id => user_players.id)
#

class UserPlayerArticle < ApplicationRecord
  belongs_to :user_player

  validates :user_player_id, presence: true
  validates :title, presence: true
  validates :article_url, presence: true

  def self.acceptable_params
    %i[id user_player_id title publication article_url notes _destroy]
  end
end
