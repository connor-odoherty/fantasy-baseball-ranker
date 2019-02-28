class CreateProjectionModels < ActiveRecord::Migration[5.0]
  def change
    create_table :projection_systems do |t|
      t.string :name
      t.string :slug
      t.integer :order_index, default: 999

      t.timestamps
    end

    # 0-Name  Team  G  PA  AB  H  2B  3B  HR  R  10-RBI  BB  SO  HBP  SB  CS  -1  17-AVG  18-OBP  19-SLG  20-OPS  21-wOBA  -1  wRC+  BsR  Fld  -1  Off  Def  WAR  -1  ADP  playerid
    create_table :batting_projections do |t|
      t.integer :player_id
      t.integer :projection_system_id

      t.float :games
      t.float :plate_appearances
      t.float :at_bats
      t.float :hits
      t.float :doubles
      t.float :triples
      t.float :home_runs
      t.float :runs
      t.float :runs_batted_in
      t.float :batting_walks
      t.float :batting_strikeouts
      t.float :stolen_bases
      t.float :batting_average
      t.float :on_base_percentage
      t.float :slugging_percentage
      t.float :on_base_plus_slugging
      t.float :weighted_on_base
      t.float :wrc_plus
      t.float :wins_above_replacement

      t.timestamps
    end

    add_foreign_key :batting_projections, :players, column: :player_id, index: { unique: true }
    add_index :batting_projections, :player_id

    add_foreign_key :batting_projections, :projection_systems, column: :projection_system_id
    add_index :batting_projections, :projection_system_id

    add_index :batting_projections, %i[player_id projection_system_id], unique: true, name: 'index_batting_projection_on_player_and_system'

    # Name  Team  W  L  ERA  GS  G  SV  IP  H  ER  HR  SO  BB  WHIP  K/9  BB/9  FIP  WAR  RA9-WAR  ADP  playerid
    create_table :pitching_projections do |t|
      t.integer :player_id
      t.integer :projection_system_id

      t.float :games
      t.float :games_started
      t.float :wins
      t.float :losses
      t.float :saves
      t.float :earned_run_average
      t.float :innings_pitched
      t.float :hits_allowed
      t.float :home_runs_allowed
      t.float :earned_runs_allowed
      t.float :pitching_walks
      t.float :pitching_strikeouts
      t.float :walks_and_hits_per_ip
      t.float :k_per_nine
      t.float :bb_per_nine
      t.float :fielding_independent_pitching
      t.float :wins_above_replacement

      t.timestamps
    end

    add_foreign_key :pitching_projections, :players, column: :player_id, index: { unique: true }
    add_index :pitching_projections, :player_id

    add_foreign_key :pitching_projections, :projection_systems, column: :projection_system_id
    add_index :pitching_projections, :projection_system_id

    add_index :pitching_projections, %i[player_id projection_system_id], unique: true, name: 'index_pitching_projection_on_player_and_system'
  end
end
