class CreateHistoricalDataModel < ActiveRecord::Migration[5.0]
  def change
    create_table :data_seasons do |t|
      t.integer :year
      t.string :name
      t.string :slug
      t.integer :order_index, default: 1000

      t.timestamps
    end

    add_index :data_seasons, :year, unique: true
    add_index :data_seasons, :order_index, unique: true

    create_table :season_batting_lines do |t|
      t.integer :player_id
      t.integer :data_season_id

      t.float :games
      t.float :plate_appearances
      t.float :at_bats
      t.float :runs
      t.float :runs_batted_in
      t.float :home_runs
      t.float :stolen_bases
      t.float :batting_average
      t.float :babip
      t.float :on_base_percentage
      t.float :slugging_percentage
      t.float :on_base_plus_slugging
      t.float :iso
      t.float :k_rate
      t.float :bb_rate
      t.float :sw_str_rate
      t.float :weighted_on_base
      t.float :wrc_plus
      t.float :line_drive_rate
      t.float :ground_ball_rate
      t.float :fly_ball_rate
      t.float :hr_to_fly_ball_rate
      t.float :infield_fly_ball_rate
      t.float :pull_rate
      t.float :center_rate
      t.float :oppo_rate
      t.float :soft_contact_rate
      t.float :medium_contact_rate
      t.float :hard_contact_rate
      t.float :wins_above_replacement

      t.integer :year

      t.timestamps
    end

    add_foreign_key :season_batting_lines, :players, column: :player_id, index: { unique: true }
    add_index :season_batting_lines, :player_id

    add_foreign_key :season_batting_lines, :data_seasons, column: :data_season_id
    add_index :season_batting_lines, :data_season_id

    add_index :season_batting_lines, :year

    add_index :season_batting_lines, %i[player_id data_season_id], unique: true, name: 'index_batting_line_on_player_and_season'

    create_table :season_pitching_lines do |t|
      t.integer :player_id
      t.integer :data_season_id

      t.float :games
      t.float :games_started
      t.float :wins
      t.float :losses
      t.float :saves
      t.float :innings_pitched
      t.float :earned_run_average
      t.float :walks_and_hits_per_ip
      t.float :k_per_nine
      t.float :bb_per_nine
      t.float :hr_per_nine
      t.float :k_rate
      t.float :bb_rate
      t.float :k_minus_bb
      t.float :sw_str_rate
      t.float :babip
      t.float :left_on_base_rate
      t.float :fielding_independent_pitching
      t.float :expected_fielding_independent_pitching
      t.float :siera
      t.float :soft_contact_rate
      t.float :medium_contact_rate
      t.float :hard_contact_rate
      t.float :wins_above_replacement

      t.integer :year

      t.timestamps
    end

    add_foreign_key :season_pitching_lines, :players, column: :player_id, index: { unique: true }
    add_index :season_pitching_lines, :player_id

    add_foreign_key :season_pitching_lines, :data_seasons, column: :data_season_id
    add_index :season_pitching_lines, :data_season_id

    add_index :season_pitching_lines, :year

    add_index :season_pitching_lines, %i[player_id data_season_id], unique: true, name: 'index_pitching_line_on_player_and_season'

    add_index :projection_systems, :slug, unique: true
    add_index :projection_systems, :order_index
  end
end
