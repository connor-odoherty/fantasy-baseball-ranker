# == Schema Information
#
# Table name: projection_systems
#
#  id          :integer          not null, primary key
#  name        :string
#  slug        :string
#  order_index :integer          default(999)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projection_systems_on_order_index  (order_index)
#  index_projection_systems_on_slug         (slug) UNIQUE
#

class ProjectionSystem < ApplicationRecord
  has_many :batting_projections
  has_many :pitching_projections
end
