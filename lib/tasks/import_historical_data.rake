task import_all_historical_data: :environment do
  years_to_import = [2016, 2017, 2018, 2019]

  years_to_import.each { |year| import_historical_data_for_year(year) }
end

def import_historical_data_for_year(year)
  data_season = DataSeason.find_by(year: year)
  data_season = DataSeason.create(year: year) unless data_season.present?

  season_lines_count = 0

  options = { downcase_header: false, strings_as_keys: true, file_encoding: 'bom|utf-8' }

  SmarterCSV.process("batting_data_#{data_season.slug}.csv", options).each do |row|
    season_lines_count += 1 if update_season_batting_line_with_row(data_season, row)
  end

  SmarterCSV.process("pitching_data_#{data_season.slug}.csv", options).each do |row|
    season_lines_count += 1 if update_season_pitching_line_with_row(data_season, row)
  end

  p "#{season_lines_count} players have data for #{data_season.name}"
end

def update_season_batting_line_with_row(data_season, row)
  row_data = StatisticsImporter::RowData.new(row)
  fangraphs_id = row_data.data_for(:fangraphs_id)
  player = Player.find_by(fg_id: fangraphs_id)

  return false unless player.present?

  season_batting_line = player.season_batting_lines.find_by(data_season: data_season)
  season_batting_line = data_season.season_batting_lines.build(player: player, year: data_season.year) unless season_batting_line.present?

  season_batting_line.build_from_row_data(row_data)

  unless season_batting_line.save
    pp season_batting_line.errors.full_messages
    raise "Season batting line for #{player.display_name} failed to save"
  end

  true
end

def update_season_pitching_line_with_row(data_season, row)
  row_data = StatisticsImporter::RowData.new(row)
  fangraphs_id = row_data.data_for(:fangraphs_id)
  player = Player.find_by(fg_id: fangraphs_id)

  return false unless player.present?

  season_pitching_line = player.season_pitching_lines.find_by(data_season: data_season)
  season_pitching_line = data_season.season_pitching_lines.build(player: player, year: data_season.year) unless season_pitching_line.present?

  season_pitching_line.build_from_row_data(row_data)

  unless season_pitching_line.save
    pp season_pitching_line.errors.full_messages
    raise "Season batting line for #{player.display_name} failed to save"
  end

  true
end
