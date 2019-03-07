module StatisticsHelper
  STATISTICS_MAP = {
    games:                         { short_name: 'G',            import_map: 'G',        display_type: :count, type: :both },
    wins_above_replacement:        { short_name: 'WAR',          import_map: 'WAR',      display_type: :count, type: :both },
    fangraphs_id:                  { short_name: 'FanGraphs ID', import_map: 'playerid', display_type: :count, type: :both },
    # G  GS  W  SV  ERA  WHIP  ERA  AVG  K/9  BB/9  K/BB  HR/9  K%  BB%  K-BB%  SwStr%  BABIP  LOB%  FIP  xFIP  SIERA  Soft%  Med%  Hard%  playerid
    games_started:                 { short_name: 'GS',           import_map: 'GS',       display_type: :count, type: :pitching },
    wins:                          { short_name: 'W',            import_map: 'W',        display_type: :count, type: :pitching },
    losses:                        { short_name: 'L',            import_map: 'L',        display_type: :count, type: :pitching },
    saves:                         { short_name: 'SV',           import_map: 'SV',       display_type: :count, type: :pitching, optional: true },
    earned_run_average:            { short_name: 'ERA',          import_map: 'ERA',      display_type: :ratio, type: :pitching },
    innings_pitched:               { short_name: 'IP',           import_map: 'IP',       display_type: :short_ratio, type: :pitching },
    hits_allowed:                  { short_name: 'HA',           import_map: 'H',        display_type: :count, type: :pitching },
    home_runs_allowed:             { short_name: 'HRA',          import_map: 'HR',       display_type: :count, type: :pitching },
    earned_runs_allowed:           { short_name: 'ERa',          import_map: 'ER',       display_type: :count, type: :pitching },
    pitching_walks:                { short_name: 'WALKS',        import_map: 'BB',       display_type: :count, type: :pitching },
    pitching_strikeouts:           { short_name: 'K',            import_map: 'SO',       display_type: :count, type: :pitching },
    walks_and_hits_per_ip:         { short_name: 'WHIP',         import_map: 'WHIP',     display_type: :ratio, type: :pitching },
    k_per_nine:                    { short_name: 'K/9',          import_map: 'K/9',      display_type: :ratio, type: :pitching },
    bb_per_nine:                   { short_name: 'BB/9',         import_map: 'BB/9',     display_type: :ratio, type: :pitching },
    hr_per_nine:                   { short_name: 'HR/9',         import_map: 'HR/9',     display_type: :ratio, type: :pitching },
    k_rate:                        { short_name: 'K%',           import_map: 'K%',       display_type: :percentage, type: :both },
    bb_rate:                       { short_name: 'BB%',          import_map: 'BB%',      display_type: :percentage, type: :both },
    k_minus_bb:                    { short_name: 'K-BB',         import_map: 'K_BB%',    display_type: :percentage, type: :pitching },
    sw_str_rate:                   { short_name: 'SwStr%',       import_map: 'SwStr%',   display_type: :percentage, type: :both },
    babip:                         { short_name: 'BABIP',        import_map: 'BABIP',    display_type: :average, type: :both },
    fielding_independent_pitching: { short_name: 'FIP',          import_map: 'FIP',      display_type: :ratio, type: :pitching },
    expected_fielding_independent_pitching: { short_name: 'xFIP', import_map: 'xFIP',    display_type: :ratio, type: :pitching },
    siera:                         { short_name: 'SIERA',        import_map: 'SIERA',    display_type: :ratio, type: :pitching },
    soft_contact_rate:             { short_name: 'Soft%',        import_map: 'Soft%',    display_type: :percentage, type: :pitching },
    medium_contact_rate:           { short_name: 'Med%',         import_map: 'Med%',     display_type: :percentage, type: :both },
    hard_contact_rate:             { short_name: 'Hard%',        import_map: 'Hard%',    display_type: :percentage, type: :both },
    left_on_base_rate:             { short_name: 'LOB%',         import_map: 'LOB%',     display_type: :percentage, type: :both },
    # G  PA R  RBI  HR SB  AVG  BABIP  OBP  SLG  OPS  ISO  K%  BB%  SwStr%  wOBA  wRC+  LD%  GB%  FB%  HR/FB  IFFB%  Pull%  Cent%  Oppo%  Soft%  Med%  Hard%  WAR
    plate_appearances:             { short_name: 'PA',           import_map: 'PA',       display_type: :count, type: :batting },
    at_bats:                       { short_name: 'AB',           import_map: 'AB',       display_type: :count, type: :batting },
    hits:                          { short_name: 'H',            import_map: 'H',        display_type: :count, type: :batting },
    doubles:                       { short_name: '2B',           import_map: '2B',       display_type: :count, type: :batting },
    triples:                       { short_name: '3B',           import_map: '3B',       display_type: :count, type: :batting },
    home_runs:                     { short_name: 'HR',           import_map: 'HR',       display_type: :count, type: :batting },
    runs:                          { short_name: 'R',            import_map: 'R',        display_type: :count, type: :batting },
    runs_batted_in:                { short_name: 'RBI',          import_map: 'RBI',      display_type: :count, type: :batting },
    batting_walks:                 { short_name: 'BB',           import_map: 'BB',       display_type: :count, type: :batting },
    batting_strikeouts:            { short_name: 'Ks',           import_map: 'SO',       display_type: :count, type: :batting },
    stolen_bases:                  { short_name: 'SB',           import_map: 'SB',       display_type: :count, type: :batting },
    batting_average:               { short_name: 'AVG',          import_map: 'AVG',      display_type: :average, type: :batting },
    on_base_percentage:            { short_name: 'OBP',          import_map: 'OBP',      display_type: :average, type: :batting },
    slugging_percentage:           { short_name: 'SLG',          import_map: 'SLG',      display_type: :average, type: :batting },
    on_base_plus_slugging:         { short_name: 'OPS',          import_map: 'OPS',      display_type: :average, type: :batting },
    weighted_on_base:              { short_name: 'wOBA',         import_map: 'wOBA',     display_type: :average, type: :batting },
    wrc_plus:                      { short_name: 'wRC+',         import_map: 'wRC+',     display_type: :count, type: :batting,  optional: true },
    iso:                           { short_name: 'ISO',          import_map: 'ISO',      display_type: :average, type: :batting,  optional: true },
    line_drive_rate:               { short_name: 'LD%',          import_map: 'LD%',      display_type: :percentage, type: :batting,  optional: true },
    ground_ball_rate:              { short_name: 'GB%',          import_map: 'GB%',      display_type: :percentage, type: :batting,  optional: true },
    fly_ball_rate:                 { short_name: 'FB%',          import_map: 'FB%',      display_type: :percentage, type: :batting,  optional: true },
    hr_to_fly_ball_rate:           { short_name: 'HR/FB',        import_map: 'HR/FB',    display_type: :percentage, type: :batting,  optional: true },
    infield_fly_ball_rate:         { short_name: 'IFFB%',        import_map: 'IFFB%',    display_type: :percentage, type: :batting,  optional: true },
    pull_rate:                     { short_name: 'Pull%',        import_map: 'Pull%',    display_type: :percentage, type: :batting,  optional: true },
    center_rate:                   { short_name: 'Cent%',        import_map: 'Cent%',    display_type: :percentage, type: :batting,  optional: true },
    oppo_rate:                     { short_name: 'Oppo%',        import_map: 'Oppo%',    display_type: :percentage, type: :batting,  optional: true }
  }.freeze

  def self.data_import_key(attribute_name)
    STATISTICS_MAP[attribute_name][:import_map]
  end

  def self.display_type(attribute_name)
    raise "No display type attributes found for field: #{attribute_name}" unless STATISTICS_MAP[attribute_name].present?
    STATISTICS_MAP[attribute_name][:display_type]
  end

  def self.display_short_name(attribute_name)
    raise "No display short name attributes found for field: #{attribute_name}" unless STATISTICS_MAP[attribute_name].present? && STATISTICS_MAP[attribute_name][:short_name].present?
    STATISTICS_MAP[attribute_name][:short_name]
  end

  def self.data_is_optional?(attribute_name)
    STATISTICS_MAP[attribute_name][:optional]
  end

  def self.batting_fields_basic
    [:games, :plate_appearances, :runs, :runs_batted_in, :home_runs, :batting_average]
  end

  def self.batting_basic
    [:games, :plate_appearances, :runs, :runs_batted_in, :home_runs, :batting_average]
  end

  def self.batting_advanced
    [:babip, :on_base_percentage, :weighted_on_base, :slugging_percentage, :on_base_plus_slugging, :iso]
  end

  def self.batting_plate_discipline
    [:k_rate, :bb_rate, :sw_str_rate]
  end

  def self.batting_contact_peripherals
    [:soft_contact_rate, :medium_contact_rate, :hard_contact_rate]
  end

  def self.batting_batted_ball_peripherals
    [:line_drive_rate, :ground_ball_rate, :fly_ball_rate, :hr_to_fly_ball_rate, :infield_fly_ball_rate]
  end

  def self.batting_directional_peripherals
    [:pull_rate, :center_rate, :oppo_rate]
  end

  def self.batting_combined_overview
    self.batting_basic + self.batting_advanced + self.batting_plate_discipline + self.batting_contact_peripherals + self.batting_batted_ball_peripherals
  end

  # PITCHING STAT LAYOUTS

  def self.pitching_fields_basic
    [:games_started, :innings_pitched, :wins, :saves, :earned_run_average, :walks_and_hits_per_ip, :k_per_nine]
  end

  def self.pitching_combined_overview
    self.basic_pitching + self.expected_era_peripherals + self.pitching_plate_rates + self.pitching_control_peripherals + self.pitching_contact_peripherals
  end

  def self.basic_pitching
    [:games_started, :innings_pitched, :wins, :saves, :earned_run_average, :walks_and_hits_per_ip]
  end

  def self.expected_era_peripherals
    [:siera, :fielding_independent_pitching, :expected_fielding_independent_pitching, :left_on_base_rate, :babip]
  end

  def self.pitching_plate_rates
    [:k_per_nine, :bb_per_nine, :hr_per_nine]
  end

  def self.pitching_control_peripherals
    [:k_rate, :bb_rate, :k_minus_bb, :sw_str_rate]
  end

  def self.pitching_contact_peripherals
    [:soft_contact_rate, :medium_contact_rate, :hard_contact_rate]
  end
end
