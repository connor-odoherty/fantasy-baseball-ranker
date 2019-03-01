class AddTagsToUserPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :user_players, :tags, :integer
  end
end
