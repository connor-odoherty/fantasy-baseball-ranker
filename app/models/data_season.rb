# == Schema Information
#
# Table name: data_seasons
#
#  id          :integer          not null, primary key
#  year        :integer
#  name        :string
#  slug        :string
#  order_index :integer          default(1000)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_data_seasons_on_order_index  (order_index) UNIQUE
#  index_data_seasons_on_year         (year) UNIQUE
#

class DataSeason < ApplicationRecord
  before_create :set_name
  before_create :set_slug
  before_create :set_order_index

  has_many :season_batting_lines
  has_many :season_pitching_lines

  private

  def set_name
    self.name = year.to_s
  end

  def set_slug
    self.slug = year.to_s
  end

  def set_order_index
    self.order_index = year
  end
end
