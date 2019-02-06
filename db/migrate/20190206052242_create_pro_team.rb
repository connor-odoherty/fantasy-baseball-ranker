class CreateProTeam < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_teams do |t|
      t.string :slug
      t.string :short_name
      t.string :long_name
    end

    add_foreign_key :players, :pro_teams, column: :current_team_id
    add_index :players, :current_team_id
    add_foreign_key :players, :pro_teams, column: :mlb_team_id
    add_index :players, :mlb_team_id
  end
end
