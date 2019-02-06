# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190206052242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "full_name"
    t.integer  "current_team_id"
    t.integer  "mlb_team_id"
    t.integer  "positions"
    t.string   "slug"
    t.datetime "dob"
    t.string   "mlb_id"
    t.string   "mlb_name"
    t.string   "mlb_pos"
    t.string   "mlb_team_short"
    t.string   "mlb_team_long"
    t.string   "mlb_depth"
    t.string   "bats"
    t.string   "throws"
    t.integer  "birth_year"
    t.string   "debut"
    t.string   "bp_id"
    t.string   "bref_id"
    t.string   "bref_name"
    t.string   "cbs_id"
    t.string   "cbs_name"
    t.string   "cbs_pos"
    t.string   "espn_id"
    t.string   "espn_name"
    t.string   "espn_pos"
    t.string   "fg_id"
    t.string   "fg_name"
    t.string   "fg_pos"
    t.string   "lahman_id"
    t.string   "nfbc_id"
    t.string   "nfbc_name"
    t.string   "nfbc_pos"
    t.string   "retro_id"
    t.string   "retro_name"
    t.string   "yahoo_id"
    t.string   "yahoo_name"
    t.string   "yahoo_pos"
    t.string   "ottoneu_id"
    t.string   "ottoneu_name"
    t.string   "ottoneu_pos"
    t.string   "rotowire_id"
    t.string   "rotowire_name"
    t.string   "rotowire_pos"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["current_team_id"], name: "index_players_on_current_team_id", using: :btree
    t.index ["mlb_team_id"], name: "index_players_on_mlb_team_id", using: :btree
  end

  create_table "pro_teams", force: :cascade do |t|
    t.string "slug"
    t.string "short_name"
    t.string "long_name"
  end

  add_foreign_key "players", "pro_teams", column: "current_team_id"
  add_foreign_key "players", "pro_teams", column: "mlb_team_id"
end
