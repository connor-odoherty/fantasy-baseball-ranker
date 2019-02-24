# == Schema Information
#
# Table name: projected_players
#
#  id                   :integer          not null, primary key
#  player_id            :integer
#  projection_system_id :integer
#  games                :float
#  plate_appearances    :float
#  at_bats              :float
#  hits                 :float
#  doubles              :float
#  triples              :float
#  home_runs            :float
#  runs                 :float
#  rbis                 :float
#  batting_walks        :float
#  batting_strikeouts   :float
#  stolen_bases         :float
#  batting_average      :float
#  on_base_percentage   :float
#  slugging_percentage  :float
#  ops                  :float
#  woba                 :float
#  wrc_plus             :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_projected_players_on_player_id                           (player_id)
#  index_projected_players_on_player_id_and_projection_system_id  (player_id,projection_system_id) UNIQUE
#  index_projected_players_on_projection_system_id                (projection_system_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (projection_system_id => projection_systems.id)
#

class ProjectedPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :projection_system
end
