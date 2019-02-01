class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string     :full_name,      required: true
      t.string     :first_name,     required: true
      t.string     :middle_name
      t.string     :last_name,      required: true
      t.string     :nickname
      t.string     :alternate_name

      t.string     :team,           required: true
      t.string     :position,       required: true
      t.string     :slug,           required: true
      t.datetime   :dob,            required: true

      t.timestamps null: false
    end
  end
end
