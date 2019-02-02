class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string     :full_name
      t.string     :team
      t.string     :position
      t.string     :slug
      t.datetime   :dob

      t.string :mlb_id
      t.string :mlb_name
      t.string :mlb_pos
      t.string :mlb_team
      t.string :mlb_team_long
      t.string :mlb_depth

      t.string :bats
      t.string :throws
      t.integer :birth_year
      t.string :debut

      t.string :bp_id
      t.string :bref_id
      t.string :bref_name

      t.string :cbs_id
      t.string :cbs_name
      t.string :cbs_pos

      t.string :espn_id
      t.string :espn_name
      t.string :espn_pos

      t.string :fg_id
      t.string :fg_name
      t.string :fg_pos

      t.string :lahman_id

      t.string :nfbc_id
      t.string :nfbc_name
      t.string :nfbc_pos

      t.string :retro_id
      t.string :retro_name

      t.string :yahoo_id
      t.string :yahoo_name
      t.string :yahoo_pos

      t.string :ottoneu_id
      t.string :ottoneu_name
      t.string :ottoneu_pos

      t.string :rotowire_id
      t.string :rotowire_name
      t.string :rotowire_pos

      t.timestamps null: false
    end
  end
end
