class CreateProjectionModels < ActiveRecord::Migration[5.0]
  def change
    create_table :projection_systems do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    create_table :projected_players do |t|
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
      t.float :rbis
      t.float :batting_walks
      t.float :batting_strikeouts
      t.float :stolen_bases
      t.float :batting_average
      t.float :on_base_percentage
      t.float :slugging_percentage
      t.float :ops
      t.float :woba
      t.float :wrc_plus

      t.timestamps
    end

    add_foreign_key :projected_players, :players, column: :player_id, index: { unique: true }
    add_index :projected_players, :player_id

    add_foreign_key :projected_players, :projection_systems, column: :projection_system_id
    add_index :projected_players, :projection_system_id

    add_index :projected_players, [:player_id, :projection_system_id], unique: true
  end
end
