class AddAdpColumnToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :adp, :float
  end
end
