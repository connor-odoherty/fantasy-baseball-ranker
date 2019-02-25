# == Schema Information
#
# Table name: projection_systems
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProjectionSystem < ApplicationRecord
  has_many :batting_projections
  has_many :pitching_projections
end
