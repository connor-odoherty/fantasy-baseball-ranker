task import_all_projection_data: :environment do
  import_projections_from_system('steamer')
end

def import_projections_from_system(system_slug)
  projection_system = ProjectionSystem.find_by(slug: system_slug)
  projection_system = ProjectionSystem.create(slug: system_slug, name: 'Steamer') unless projection_system.present?

  player_projections_count = 1

  CSV.foreach('steamer_projections_batting.csv') do |row|
    next if row[0] == 'Name'
    player_projections_count += 1 if update_steamer_projection_batting_with_row(projection_system, row)
  end

  CSV.foreach('steamer_projections_pitching.csv') do |row|
    next if row[0] == 'Name'
    player_projections_count += 1 if update_steamer_projection_pitching_with_row(projection_system, row)
  end

  p "#{player_projections_count} players have projections"
end

# 0-Name	Team	G	PA	AB	H	2B	3B	HR	R	10-RBI	BB	SO	HBP	SB	CS	-1	17-AVG	18-OBP	19-SLG	20-OPS	21-wOBA	-1	wRC+	BsR	Fld	-1	Off	Def	29-WAR	-1	ADP	playerid
def update_steamer_projection_batting_with_row(projection_system, row)
  fangraphs_id = row[32]
  player = Player.find_by(fg_id: fangraphs_id)

  if !player.present?
    p "#{row[0]} was not found with id -#{fangraphs_id}-"
    return false
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
      runs_batted_in: row[10],
      batting_walks: row[11],
      batting_strikeouts: row[12],
      stolen_bases: row[14],
      batting_average: row[17],
      on_base_percentage: row[18],
      slugging_percentage: row[19],
      on_base_plus_slugging: row[20],
      weighted_on_base: row[21],
      wrc_plus: row[23],
      wins_above_replacement: row[29]
  }

  projected_player = player.batting_projections.find_by(projection_system: projection_system)
  projected_player = projection_system.batting_projections.build(player: player) if !projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  if !projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end
``
  return true
end

# 0-Name	Team	W	L	ERA	GS	G	SV	IP	H	10-ER	HR	SO	BB	WHIP	K/9	BB/9	FIP	WAR	RA9-WAR	20-ADP 21-playerid
def update_steamer_projection_pitching_with_row(projection_system, row)
  fangraphs_id = row[21]
  player = Player.find_by(fg_id: fangraphs_id)

  if !player.present?
    p "#{row[0]} was not found with id -#{fangraphs_id}-"
    return false
  end

  source_projection_data = {
      wins: row[2],
      losses: row[3],
      earned_run_average: row[4],
      games_started: row[5],
      games: row[6],
      saves: row[7],
      innings_pitched: row[8],
      hits_allowed: row[9],
      earned_runs_allowed: row[10],
      home_runs_allowed: row[11],
      pitching_strikeouts: row[12],
      pitching_walks: row[13],
      walks_and_hits_per_ip: row[14],
      k_per_nine: row[15],
      bb_per_nine: row[16],
      fielding_independent_pitching: row[17],
      wins_above_replacement: row[18]
  }

  projected_player = player.pitching_projections.find_by(projection_system: projection_system)
  projected_player = projection_system.pitching_projections.build(player: player) if !projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  if !projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end

  return true
end