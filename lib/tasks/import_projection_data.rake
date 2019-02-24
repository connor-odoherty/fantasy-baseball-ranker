task import_all_projection_data: :environment do
  import_projections_from_system('steamer')
end

def import_projections_from_system(system_slug)
  projection_system = ProjectionSystem.find_by(slug: system_slug)
  if !projection_system.present?
    projection_system = ProjectionSystem.create(slug: system_slug, name: 'Steamer')
  end
  player_projections_count = 1

  # 0-Name	Team	G	PA	AB	H	2B	3B	HR	R	10-RBI	BB	SO	HBP	SB	CS	-1	17-AVG	18-OBP	19-SLG	20-OPS	21-wOBA	-1	wRC+	BsR	Fld	-1	Off	Def	WAR	-1	ADP	playerid
  CSV.foreach('steamer_projections.csv') do |row|
    next if row[0] == 'Name'

    fangraphs_id = row[32]
    player = Player.find_by(fg_id: fangraphs_id)
    if !player.present?
      p "#{row[0]} was not found with id -#{fangraphs_id}-"
      next
    end

    source_projection_data = {
      games: row[2],
      plate_appearances: row[3],
      at_bats: row[4],
      hits: row[5],
      doubles: row[6],
      triples: row[7],
      home_runs: row[8],
      runs: row[9],
      rbis: row[10],
      batting_walks: row[11],
      batting_strikeouts: row[12],
      stolen_bases: row[14],
      batting_average: row[17],
      on_base_percentage: row[18],
      slugging_percentage: row[19],
      ops: row[20],
      woba: row[21],
      wrc_plus: row[23]
    }

    projected_player = player.projected_players.find_by(projection_system: projection_system)
    projected_player = projection_system.projected_players.build(player: player) if !projected_player.present?

    projected_player.assign_attributes(source_projection_data)

    if !projected_player.save
      pp projected_player.errors.full_messages
      raise "Projected player #{player.display_name} failed to save"
    end

    player_projections_count += 1
  end

  p "#{player_projections_count} players have projections"
end