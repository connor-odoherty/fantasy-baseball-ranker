# == Schema Information
#
# Table name: player_articles
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  title       :string
#  publication :string
#  article_url :string
#  notes       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_player_articles_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#

class PlayerArticle < ApplicationRecord
  belongs_to :player

  def self.acceptable_attributes
    [:id, :player_id, :title, :publication, :article_url, :notes]
  end

  validates :player_id, presence: true
  validates :title, presence: true
  validates :article_url, presence: true
end
