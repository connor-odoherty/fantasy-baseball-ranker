module StatisticsHelper
  STATISTICS_MAP = {
    games:                         { short_name: 'G',     import_map: :g,    display_type: :type, type: :both },
    wins_above_replacement:        { short_name: 'WAR',   import_map: :war,  display_type: :type, type: :both },
    fangraphs_id:                  { short_name: 'FanGraphs ID', import_map: :playerid, display_type: :type, type: :both },
    games_started:                 { short_name: 'GS',    import_map: :gs,   display_type: :type, type: :pitching },
    wins:                          { short_name: 'W',     import_map: :w,    display_type: :type, type: :pitching },
    losses:                        { short_name: 'L',     import_map: :l,    display_type: :type, type: :pitching },
    saves:                         { short_name: 'SV',    import_map: :sv,   display_type: :type, type: :pitching, optional: true },
    earned_run_average:            { short_name: 'ERA',   import_map: :era,  display_type: :type, type: :pitching },
    innings_pitched:               { short_name: 'IP',    import_map: :ip,   display_type: :type, type: :pitching },
    hits_allowed:                  { short_name: 'HA',    import_map: :h,    display_type: :type, type: :pitching },
    home_runs_allowed:             { short_name: 'HRA',   import_map: :hr,   display_type: :type, type: :pitching },
    earned_runs_allowed:           { short_name: 'ERa',   import_map: :er,   display_type: :type, type: :pitching },
    pitching_walks:                { short_name: 'WALKS', import_map: :bb,   display_type: :type, type: :pitching },
    pitching_strikeouts:           { short_name: 'K',     import_map: :so,   display_type: :type, type: :pitching },
    walks_and_hits_per_ip:         { short_name: 'WHIP',  import_map: :whip, display_type: :type, type: :pitching },
    k_per_nine:                    { short_name: 'K/9',   import_map: :'k/9',  display_type: :type, type: :pitching },
    bb_per_nine:                   { short_name: 'BB/9',  import_map: :'bb/9', display_type: :type, type: :pitching },
    fielding_independent_pitching: { short_name: 'FIP',   import_map: :fip,  display_type: :type, type: :pitching },
    plate_appearances:             { short_name: 'PA',    import_map: :pa,   display_type: :type, type: :batting },
    at_bats:                       { short_name: 'AB',    import_map: :ab,   display_type: :type, type: :batting },
    hits:                          { short_name: 'H',     import_map: :h,    display_type: :type, type: :batting },
    doubles:                       { short_name: '2B',    import_map: :'2b',   display_type: :type, type: :batting },
    triples:                       { short_name: '3B',    import_map: :'3b',   display_type: :type, type: :batting },
    home_runs:                     { short_name: 'HR',    import_map: :hr,   display_type: :type, type: :batting },
    runs:                          { short_name: 'R',     import_map: :r,    display_type: :type, type: :batting },
    runs_batted_in:                { short_name: 'RBI',   import_map: :rbi,  display_type: :type, type: :batting },
    batting_walks:                 { short_name: 'BB',    import_map: :bb,   display_type: :type, type: :batting },
    batting_strikeouts:            { short_name: 'Ks',    import_map: :so,   display_type: :type, type: :batting },
    stolen_bases:                  { short_name: 'SB',    import_map: :sb,   display_type: :type, type: :batting },
    batting_average:               { short_name: 'AVG',   import_map: :avg,  display_type: :type, type: :batting },
    on_base_percentage:            { short_name: 'OBP',   import_map: :obp,  display_type: :type, type: :batting },
    slugging_percentage:           { short_name: 'SLG',   import_map: :slg,  display_type: :type, type: :batting },
    on_base_plus_slugging:         { short_name: 'OPS',   import_map: :ops,  display_type: :type, type: :batting },
    weighted_on_base:              { short_name: 'wOBA',  import_map: :woba, display_type: :type, type: :batting },
    wrc_plus:                      { short_name: 'wRC+',  import_map: :'wrc+', display_type: :type, type: :batting, optional: true }
  }.freeze

  def self.data_import_key(attribute_name)
    STATISTICS_MAP[attribute_name][:import_map]
  end

  def self.data_is_optional?(attribute_name)
    STATISTICS_MAP[attribute_name][:optional]
  end
end
