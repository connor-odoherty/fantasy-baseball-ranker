# frozen_string_literal: true

task import_team_data: :environment do
  team_update_count = 0
  team_create_count = 0
  CSV.foreach('mlb_team_master.csv') do |row|
    # short_name  long_name
    next if row[0] == 'short_name'

    source_team_data = {
      slug: row[0],
      short_name: row[0],
      long_name: row[1]
    }
    team = ProTeam.find_by(slug: source_team_data[:slug])

    if team.present?
      team.update(source_team_data)
      team_update_count += 1

    else
      ProTeam.create(source_team_data)
      team_create_count += 1
    end
  end

  p "#{team_update_count} teams updated" if team_update_count > 0
  p "#{team_create_count} teams created" if team_create_count > 0
end

task import_player_data: :environment do
  fantasy_relevant_player_names = []
  count = 0

  CSV.foreach('fantasy_players.csv') do |row|
    # name  status  age  team  pos
    next if row[0] == 'name'

    fantasy_relevant_player_names.push(row[0].downcase)
  end

  fantasy_relevant_player_pool = fantasy_relevant_player_names.to_set

  CSV.foreach('mlb_player_source_master.csv') do |row|
    next if row[0] == 'mlb_id'

    source_player_data = {
      mlb_id: row[0],
      mlb_name: row[1],
      mlb_pos: row[2],
      mlb_team_short: row[3],
      mlb_team_long: row[4],
      bats: row[5],
      throws: row[6],
      birth_year: row[7],
      bp_id: row[8],
      bref_id: row[9],
      bref_name: row[10],
      cbs_id: row[11],
      cbs_name: row[12],
      cbs_pos: row[13],
      espn_id: row[14],
      espn_name: row[15],
      espn_pos: row[16],
      fg_id: row[17],
      fg_name: row[18],
      fg_pos: row[19],
      lahman_id: row[20],
      nfbc_id: row[21],
      nfbc_name: row[22],
      nfbc_pos: row[23],
      retro_id: row[24],
      retro_name: row[25],
      debut: row[26],
      yahoo_id: row[27],
      yahoo_name: row[28],
      yahoo_pos: row[29],
      mlb_depth: row[30],
      ottoneu_id: row[31],
      ottoneu_name: row[32],
      ottoneu_pos: row[33],
      rotowire_id: row[34],
      rotowire_name: row[35],
      rotowire_pos: row[36]
    }

    source_player_name_pool = [
      source_player_data[:mlb_name]&.downcase,
      source_player_data[:bref_name]&.downcase,
      source_player_data[:cbs_name]&.downcase,
      source_player_data[:espn_name]&.downcase,
      source_player_data[:fg_name]&.downcase,
      source_player_data[:nfbc_name]&.downcase,
      source_player_data[:retro_name]&.downcase,
      source_player_data[:yahoo_name]&.downcase,
      source_player_data[:retro_name]&.downcase,
      source_player_data[:ottoneu_name]&.downcase,
      source_player_data[:rotowire_name]&.downcase
    ].to_set

    next unless fantasy_relevant_player_pool.intersect? source_player_name_pool

    fantasy_relevant_player_pool.subtract(source_player_name_pool)

    source_player = Player.find_by(mlb_id: source_player_data[:mlb_id])

    if source_player.present?
      source_player.assign_attributes(source_player_data)
    else
      source_player = Player.new(source_player_data)
      source_player.assign_attributes(
        full_name: source_player_data[:mlb_name]
      )
    end

    pp "Working on: #{source_player.full_name}"

    combined_list_of_positions_from_player_model(source_player).each { |position| source_player.positions << position }

    raise "#{source_player.mlb_name} failed to save" unless source_player.save

    mlb_team_for_player = ProTeam.find_by(slug: source_player.mlb_team_short)

    raise "No team with slug #{source_player.mlb_team_short} found for player #{source_player.full_name}" unless mlb_team_for_player.present?

    source_player.update_column(:current_team_id, mlb_team_for_player.id)
    source_player.update_column(:mlb_team_id, mlb_team_for_player.id)

    fantasy_relevant_player_pool.delete(source_player.mlb_name)
    p "#{source_player.mlb_name} saved successfully"
    count += 1
  end

  if count != fantasy_relevant_player_names.length
    p 'These players failed to import:'
    pp fantasy_relevant_player_pool
    # raise 'Missing some fantasy relevant players'
  end

  p "#{count} players successfully imported!"
end

def combined_list_of_positions_from_player_model(player)
  combined_positions = []
  combined_positions += parse_positions(player.mlb_pos)
  combined_positions += parse_positions(player.cbs_pos)
  combined_positions += parse_positions(player.espn_pos)
  combined_positions += parse_positions(player.nfbc_pos)
  combined_positions += parse_positions(player.yahoo_pos)
  # combined_positions += parse_positions(player.ottoneu_pos) # Ottoneu lists everyone as RP
  combined_positions += parse_positions(player.rotowire_pos)
  combined_positions.uniq
end

def parse_positions(position_string)
  positions = []
  return positions unless position_string.present?

  position_string.split('/').each do |pos|
    case pos
    when 'C', 'Catcher'
      positions << :catcher
    when '1B', 'First Base'
      positions << :first_base
      positions << :infield
    when '2B', 'Second Base'
      positions << :second_base
      positions << :infield
    when '3B', 'Third Base'
      positions << :third_base
      positions << :infield
    when 'SS', 'Short Stop'
      positions << :short_stop
      positions << :infield
    when 'LF', 'Left Field'
      positions << :left_field
      positions << :outfield
    when 'CF' 'Center Field'
      positions << :center_field
      positions << :outfield
    when 'RF', 'Right Field'
      positions << :right_field
      positions << :outfield
    when 'OF', 'Outfield'
      positions << :outfield
    when 'U', 'Util'
      positions << :utility
    when 'SP', 'Starting Pitcher'
      positions << :starting_pitcher
      positions << :pitcher
    when 'RP', 'Relief Pitcher'
      positions << :relief_pitcher
      positions << :pitcher
      end
  end

  positions
end
