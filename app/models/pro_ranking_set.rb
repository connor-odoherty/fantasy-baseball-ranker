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

class ProRankingSet < ApplicationRecord
  has_many :pro_ranking_players

  validates :publication_name, presence: true
  validates :ranking_name, presence: true
  validates :slug, presence: true
  validates :url, presence: true

  def display_name
    "#{publication_name} #{ranking_name}"
  end
end
