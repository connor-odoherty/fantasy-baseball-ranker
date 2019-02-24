# frozen_string_literal: true

# == Schema Information
#
# Table name: pro_ranking_sets
#
#  id               :integer          not null, primary key
#  publication_name :string
#  ranking_name     :string
#  ranker_name      :string
#  url              :string
#  published_at     :datetime
#  slug             :string
#
# Indexes
#
#  index_pro_ranking_sets_on_slug  (slug) UNIQUE
#

class ProRankingSet < ApplicationRecord
  has_many :pro_ranking_players, -> { order(ovr_rank: :asc) }

  validates :publication_name, presence: true
  validates :ranking_name, presence: true
  validates :slug, presence: true
  validates :url, presence: true

  extend FriendlyId
  friendly_id :publication_and_name_to_slug, :use => %i[slugged finders]

  def display_name
    "#{publication_name} #{ranking_name}"
  end

  def publication_and_name_to_slug
    ActiveSupport::Inflector.parameterize("#{publication_name} #{ranking_name}")
  end
end
