# import StatisticsHelper
# require 'lib/statistics_importer'
task import_all_projection_data: :environment do
  projection_systems_attributes = [
    {
      name: 'ATC',
      slug: 'atc',
      order_index: -1,
      batting_file: 'atc_projections_batting.csv',
      pitching_file: 'atc_projections_pitching.csv'
    },
    {
      name: 'Steamer',
      slug: 'steamer',
      order_index: 0,
      batting_file: 'steamer_projections_batting.csv',
      pitching_file: 'steamer_projections_pitching.csv'
    },
    {
      name: 'ZiPS',
      slug: 'zips',
      order_index: 5,
      batting_file: 'zips_projections_batting.csv',
      pitching_file: 'zips_projections_pitching.csv'
    }
  ]
  projection_systems_attributes.each { |pa| import_projections_from_system(pa) }
end

def import_projections_from_system(projection_system_attributes)
  pp 'Importing system:', projection_system_attributes
  projection_system = ProjectionSystem.find_by(slug: projection_system_attributes[:slug])
  projection_system = ProjectionSystem.create(projection_system_attributes.except(:batting_file, :pitching_file)) unless projection_system.present?

  player_projections_count = 0

  options = {
    header_transformations: %i[none keys_as_strings]
  }
  SmarterCSV.process(projection_system_attributes[:batting_file], downcase_header: false, strings_as_keys: true).each do |row|
    player_projections_count += 1 if update_batting_projection_with_row(projection_system, row)
  end

  SmarterCSV.process(projection_system_attributes[:pitching_file], downcase_header: false, strings_as_keys: true).each do |row|
    player_projections_count += 1 if update_pitching_projection_with_row(projection_system, row)
  end

  p "#{player_projections_count} players have projections for #{projection_system.name}"
end

def update_batting_projection_with_row(projection_system, row)
  row_data = StatisticsImporter::RowData.new(row)
  fangraphs_id = row_data.data_for(:fangraphs_id)
  player = Player.find_by(fg_id: fangraphs_id)

  unless player.present?
    # p "#{row[:name]} was not found with id -#{fangraphs_id}-"
    return false
  end

  source_projection_data = {
    games: row_data.data_for(:games),
    plate_appearances: row_data.data_for(:plate_appearances),
    at_bats: row_data.data_for(:at_bats),
    hits: row_data.data_for(:hits),
    doubles: row_data.data_for(:doubles),
    triples: row_data.data_for(:triples),
    home_runs: row_data.data_for(:home_runs),
    runs: row_data.data_for(:runs),
    runs_batted_in: row_data.data_for(:runs_batted_in),
    batting_walks: row_data.data_for(:batting_walks),
    batting_strikeouts: row_data.data_for(:batting_strikeouts),
    stolen_bases: row_data.data_for(:stolen_bases),
    batting_average: row_data.data_for(:batting_average),
    on_base_percentage: row_data.data_for(:on_base_percentage),
    slugging_percentage: row_data.data_for(:slugging_percentage),
    on_base_plus_slugging: row_data.data_for(:on_base_plus_slugging),
    weighted_on_base: row_data.data_for(:weighted_on_base),
    wrc_plus: row_data.data_for(:wrc_plus),
    wins_above_replacement: row_data.data_for(:wins_above_replacement)
  }

  projected_player = player.batting_projections.find_by(projection_system: projection_system)
  projected_player = projection_system.batting_projections.build(player: player) unless projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  unless projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end

  true
end

def update_pitching_projection_with_row(projection_system, row)
  row_data = StatisticsImporter::RowData.new(row)
  fangraphs_id = row_data.data_for(:fangraphs_id)
  player = Player.find_by(fg_id: fangraphs_id)

  unless player.present?
    # p "#{row[:name]} was not found with id -#{fangraphs_id}-"
    return false
  end

  source_projection_data = {
    wins: row_data.data_for(:wins),
      losses: row_data.data_for(:losses),
      earned_run_average: row_data.data_for(:earned_run_average),
      games_started: row_data.data_for(:games_started),
      games: row_data.data_for(:games),
      saves: row_data.data_for(:saves),
      innings_pitched: row_data.data_for(:innings_pitched),
      hits_allowed: row_data.data_for(:hits_allowed),
      earned_runs_allowed: row_data.data_for(:earned_runs_allowed),
      home_runs_allowed: row_data.data_for(:home_runs_allowed),
      pitching_strikeouts: row_data.data_for(:pitching_strikeouts),
      pitching_walks: row_data.data_for(:pitching_walks),
      walks_and_hits_per_ip: row_data.data_for(:walks_and_hits_per_ip),
      k_per_nine: row_data.data_for(:k_per_nine),
      bb_per_nine: row_data.data_for(:bb_per_nine),
      fielding_independent_pitching: row_data.data_for(:fielding_independent_pitching),
      wins_above_replacement: row_data.data_for(:wins_above_replacement)
  }

  projected_player = player.pitching_projections.find_by(projection_system: projection_system)
  projected_player = projection_system.pitching_projections.build(player: player) unless projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  unless projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end

  true
end

# 0-Name  Team  G  PA  AB  H  2B  3B  HR  R  10-RBI  BB  SO  HBP  SB  CS  -1  17-AVG  18-OBP  19-SLG  20-OPS  21-wOBA  -1  wRC+  BsR  Fld  -1  Off  Def  29-WAR  -1  ADP  playerid
def update_steamer_projection_batting_with_row(projection_system, row)
  fangraphs_id = row[32]
  player = Player.find_by(fg_id: fangraphs_id)

  unless player.present?
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
  projected_player = projection_system.batting_projections.build(player: player) unless projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  unless projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end

  true
end

# 0-Name  Team  W  L  ERA  GS  G  SV  IP  H  10-ER  HR  SO  BB  WHIP  K/9  BB/9  FIP  WAR  RA9-WAR  20-ADP 21-playerid
def update_steamer_projection_pitching_with_row(projection_system, row)
  fangraphs_id = row[21]
  player = Player.find_by(fg_id: fangraphs_id)

  unless player.present?
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
  projected_player = projection_system.pitching_projections.build(player: player) unless projected_player.present?

  projected_player.assign_attributes(source_projection_data)

  unless projected_player.save
    pp projected_player.errors.full_messages
    raise "Projected player #{player.display_name} failed to save"
  end

  true
end
