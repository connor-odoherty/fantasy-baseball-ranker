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

ActiveRecord::Schema.define(version: 20190209053315) do

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

  create_table "pro_ranking_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "pro_ranking_set_id"
    t.integer "ovr_rank"
    t.text    "notes"
    t.float   "adp"
    t.integer "min_pick"
    t.integer "max_pick"
    t.index ["player_id"], name: "index_pro_ranking_players_on_player_id", using: :btree
    t.index ["pro_ranking_set_id"], name: "index_pro_ranking_players_on_pro_ranking_set_id", using: :btree
  end

  create_table "pro_ranking_sets", force: :cascade do |t|
    t.string   "publication_name"
    t.string   "ranking_name"
    t.string   "ranker_name"
    t.string   "url"
    t.datetime "published_at"
    t.string   "slug"
    t.index ["slug"], name: "index_pro_ranking_sets_on_slug", unique: true, using: :btree
  end

  create_table "pro_teams", force: :cascade do |t|
    t.string "slug"
    t.string "short_name"
    t.string "long_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "players", "pro_teams", column: "current_team_id"
  add_foreign_key "players", "pro_teams", column: "mlb_team_id"
  add_foreign_key "pro_ranking_players", "players"
  add_foreign_key "pro_ranking_players", "pro_ranking_sets"
end
