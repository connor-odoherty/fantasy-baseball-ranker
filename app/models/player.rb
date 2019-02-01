# == Schema Information
#
# Table name: players
#
#  id             :integer          not null, primary key
#  full_name      :string
#  first_name     :string
#  middle_name    :string
#  last_name      :string
#  nickname       :string
#  alternate_name :string
#  team           :string
#  position       :string
#  slug           :string
#  dob            :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Player < ApplicationRecord

end
