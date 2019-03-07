module StatisticsHelper
  STATISTICS_MAP = {
    games:                         { short_name: 'G',            import_map: 'G',    display_type: :type, type: :both },
    wins_above_replacement:        { short_name: 'WAR',          import_map: 'WAR',  display_type: :type, type: :both },
    fangraphs_id:                  { short_name: 'FanGraphs ID', import_map: 'playerid', display_type: :type, type: :both },
    games_started:                 { short_name: 'GS',           import_map: 'GS',   display_type: :type, type: :pitching },
    wins:                          { short_name: 'W',            import_map: 'W',    display_type: :type, type: :pitching },
    losses:                        { short_name: 'L',            import_map: 'L',    display_type: :type, type: :pitching },
    saves:                         { short_name: 'SV',           import_map: 'SV',   display_type: :type, type: :pitching, optional: true },
    earned_run_average:            { short_name: 'ERA',          import_map: 'ERA',  display_type: :type, type: :pitching },
    innings_pitched:               { short_name: 'IP',           import_map: 'IP',   display_type: :type, type: :pitching },
    hits_allowed:                  { short_name: 'HA',           import_map: 'H',    display_type: :type, type: :pitching },
    home_runs_allowed:             { short_name: 'HRA',          import_map: 'HR',   display_type: :type, type: :pitching },
    earned_runs_allowed:           { short_name: 'ERa',          import_map: 'ER',   display_type: :type, type: :pitching },
    pitching_walks:                { short_name: 'WALKS',        import_map: 'BB',   display_type: :type, type: :pitching },
    pitching_strikeouts:           { short_name: 'K',            import_map: 'SO',   display_type: :type, type: :pitching },
    walks_and_hits_per_ip:         { short_name: 'WHIP',         import_map: 'WHIP', display_type: :type, type: :pitching },
    k_per_nine:                    { short_name: 'K/9',          import_map: 'K/9',  display_type: :type, type: :pitching },
    bb_per_nine:                   { short_name: 'BB/9',         import_map: 'BB/9', display_type: :type, type: :pitching },
    fielding_independent_pitching: { short_name: 'FIP',          import_map: 'FIP',  display_type: :type, type: :pitching },
    plate_appearances:             { short_name: 'PA',           import_map: 'PA',   display_type: :type, type: :batting },
    at_bats:                       { short_name: 'AB',           import_map: 'AB',   display_type: :type, type: :batting },
    hits:                          { short_name: 'H',            import_map: 'H',    display_type: :type, type: :batting },
    doubles:                       { short_name: '2B',           import_map: '2B',   display_type: :type, type: :batting },
    triples:                       { short_name: '3B',           import_map: '3B',   display_type: :type, type: :batting },
    home_runs:                     { short_name: 'HR',           import_map: 'HR',   display_type: :type, type: :batting },
    runs:                          { short_name: 'R',            import_map: 'R',    display_type: :type, type: :batting },
    runs_batted_in:                { short_name: 'RBI',          import_map: 'RBI',  display_type: :type, type: :batting },
    batting_walks:                 { short_name: 'BB',           import_map: 'BB',   display_type: :type, type: :batting },
    batting_strikeouts:            { short_name: 'Ks',           import_map: 'SO',   display_type: :type, type: :batting },
    stolen_bases:                  { short_name: 'SB',           import_map: 'SB',   display_type: :type, type: :batting },
    batting_average:               { short_name: 'AVG',          import_map: 'AVG',  display_type: :type, type: :batting },
    on_base_percentage:            { short_name: 'OBP',          import_map: 'OBP',  display_type: :type, type: :batting },
    slugging_percentage:           { short_name: 'SLG',          import_map: 'SLG',  display_type: :type, type: :batting },
    on_base_plus_slugging:         { short_name: 'OPS',          import_map: 'OPS',  display_type: :type, type: :batting },
    weighted_on_base:              { short_name: 'wOBA',         import_map: 'OPS',  display_type: :type, type: :batting },
    wrc_plus:                      { short_name: 'wRC+',         import_map: 'WRC+', display_type: :type, type: :batting, optional: true }
  }.freeze

  def self.data_import_key(attribute_name)
    STATISTICS_MAP[attribute_name][:import_map]
  end

  def self.data_is_optional?(attribute_name)
    STATISTICS_MAP[attribute_name][:optional]
  end
end
