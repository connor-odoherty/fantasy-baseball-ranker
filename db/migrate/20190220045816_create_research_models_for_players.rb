class CreateResearchModelsForPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :notes, :text
    add_column :players, :autocomplete_search_field, :string

    create_table :player_articles do |t|
      t.integer :player_id
      t.string :title
      t.string :publication
      t.string :article_url
      t.text :notes
      t.timestamps
    end

    add_foreign_key :player_articles, :players, column: :player_id
    add_index :player_articles, :player_id
  end
end
