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

ActiveRecord::Schema.define(version: 20190306065717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batting_projections", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "projection_system_id"
    t.float    "games"
    t.float    "plate_appearances"
    t.float    "at_bats"
    t.float    "hits"
    t.float    "doubles"
    t.float    "triples"
    t.float    "home_runs"
    t.float    "runs"
    t.float    "runs_batted_in"
    t.float    "batting_walks"
    t.float    "batting_strikeouts"
    t.float    "stolen_bases"
    t.float    "batting_average"
    t.float    "on_base_percentage"
    t.float    "slugging_percentage"
    t.float    "on_base_plus_slugging"
    t.float    "weighted_on_base"
    t.float    "wrc_plus"
    t.float    "wins_above_replacement"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["player_id", "projection_system_id"], name: "index_batting_projection_on_player_and_system", unique: true, using: :btree
    t.index ["player_id"], name: "index_batting_projections_on_player_id", using: :btree
    t.index ["projection_system_id"], name: "index_batting_projections_on_projection_system_id", using: :btree
  end

  create_table "data_seasons", force: :cascade do |t|
    t.integer  "year"
    t.string   "name"
    t.string   "slug"
    t.integer  "order_index", default: 1000
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["order_index"], name: "index_data_seasons_on_order_index", unique: true, using: :btree
    t.index ["year"], name: "index_data_seasons_on_year", unique: true, using: :btree
  end

  create_table "pitching_projections", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "projection_system_id"
    t.float    "games"
    t.float    "games_started"
    t.float    "wins"
    t.float    "losses"
    t.float    "saves"
    t.float    "earned_run_average"
    t.float    "innings_pitched"
    t.float    "hits_allowed"
    t.float    "home_runs_allowed"
    t.float    "earned_runs_allowed"
    t.float    "pitching_walks"
    t.float    "pitching_strikeouts"
    t.float    "walks_and_hits_per_ip"
    t.float    "k_per_nine"
    t.float    "bb_per_nine"
    t.float    "fielding_independent_pitching"
    t.float    "wins_above_replacement"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["player_id", "projection_system_id"], name: "index_pitching_projection_on_player_and_system", unique: true, using: :btree
    t.index ["player_id"], name: "index_pitching_projections_on_player_id", using: :btree
    t.index ["projection_system_id"], name: "index_pitching_projections_on_projection_system_id", using: :btree
  end

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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "autocomplete_search_field"
    t.index ["current_team_id"], name: "index_players_on_current_team_id", using: :btree
    t.index ["fg_id"], name: "index_players_on_fg_id", unique: true, using: :btree
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
    t.index ["player_id", "pro_ranking_set_id"], name: "index_unique_on_player_and_pro_ranking_set", unique: true, using: :btree
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

  create_table "projection_systems", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "order_index", default: 999
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["order_index"], name: "index_projection_systems_on_order_index", using: :btree
    t.index ["slug"], name: "index_projection_systems_on_slug", unique: true, using: :btree
  end

  create_table "season_batting_lines", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "data_season_id"
    t.float    "games"
    t.float    "plate_appearances"
    t.float    "at_bats"
    t.float    "runs"
    t.float    "runs_batted_in"
    t.float    "home_runs"
    t.float    "stolen_bases"
    t.float    "batting_average"
    t.float    "babip"
    t.float    "on_base_percentage"
    t.float    "slugging_percentage"
    t.float    "on_base_plus_slugging"
    t.float    "iso"
    t.float    "k_rate"
    t.float    "bb_rate"
    t.float    "sw_str_rate"
    t.float    "weighted_on_base"
    t.float    "wrc_plus"
    t.float    "line_drive_rate"
    t.float    "ground_ball_rate"
    t.float    "fly_ball_rate"
    t.float    "hr_to_fly_ball_rate"
    t.float    "infield_fly_ball_rate"
    t.float    "pull_rate"
    t.float    "center_rate"
    t.float    "oppo_rate"
    t.float    "soft_contact_rate"
    t.float    "medium_contact_rate"
    t.float    "hard_contact_rate"
    t.float    "wins_above_replacement"
    t.integer  "year"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["data_season_id"], name: "index_season_batting_lines_on_data_season_id", using: :btree
    t.index ["player_id", "data_season_id"], name: "index_batting_line_on_player_and_season", unique: true, using: :btree
    t.index ["player_id"], name: "index_season_batting_lines_on_player_id", using: :btree
    t.index ["year"], name: "index_season_batting_lines_on_year", using: :btree
  end

  create_table "season_pitching_lines", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "data_season_id"
    t.float    "games"
    t.float    "games_started"
    t.float    "wins"
    t.float    "losses"
    t.float    "saves"
    t.float    "innings_pitched"
    t.float    "earned_run_average"
    t.float    "walks_and_hits_per_ip"
    t.float    "k_per_nine"
    t.float    "bb_per_nine"
    t.float    "hr_per_nine"
    t.float    "k_rate"
    t.float    "bb_rate"
    t.float    "k_minus_bb"
    t.float    "sw_str_rate"
    t.float    "babip"
    t.float    "left_on_base_rate"
    t.float    "fielding_independent_pitching"
    t.float    "expected_fielding_independent_pitching"
    t.float    "siera"
    t.float    "soft_contact_rate"
    t.float    "medium_contact_rate"
    t.float    "hard_contact_rate"
    t.float    "wins_above_replacement"
    t.integer  "year"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["data_season_id"], name: "index_season_pitching_lines_on_data_season_id", using: :btree
    t.index ["player_id", "data_season_id"], name: "index_pitching_line_on_player_and_season", unique: true, using: :btree
    t.index ["player_id"], name: "index_season_pitching_lines_on_player_id", using: :btree
    t.index ["year"], name: "index_season_pitching_lines_on_year", using: :btree
  end

  create_table "user_player_articles", force: :cascade do |t|
    t.integer  "user_player_id"
    t.string   "title"
    t.string   "publication"
    t.string   "article_url"
    t.text     "notes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_player_id"], name: "index_user_player_articles_on_user_player_id", using: :btree
  end

  create_table "user_players", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tags"
    t.index ["player_id", "user_id"], name: "index_user_players_on_player_id_and_user_id", unique: true, using: :btree
    t.index ["player_id"], name: "index_user_players_on_player_id", using: :btree
    t.index ["user_id"], name: "index_user_players_on_user_id", using: :btree
  end

  create_table "user_ranking_players", force: :cascade do |t|
    t.integer "user_player_id"
    t.integer "user_ranking_set_id"
    t.integer "ovr_rank"
    t.integer "elo_score"
    t.integer "position"
    t.index ["elo_score"], name: "index_user_ranking_players_on_elo_score", using: :btree
    t.index ["ovr_rank"], name: "index_user_ranking_players_on_ovr_rank", using: :btree
    t.index ["user_player_id", "user_ranking_set_id"], name: "index_unique_on_user_player_and_user_ranking_set", unique: true, using: :btree
    t.index ["user_player_id"], name: "index_user_ranking_players_on_user_player_id", using: :btree
    t.index ["user_ranking_set_id"], name: "index_user_ranking_players_on_user_ranking_set_id", using: :btree
  end

  create_table "user_ranking_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ranking_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_user_ranking_sets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "batting_projections", "players"
  add_foreign_key "batting_projections", "projection_systems"
  add_foreign_key "pitching_projections", "players"
  add_foreign_key "pitching_projections", "projection_systems"
  add_foreign_key "players", "pro_teams", column: "current_team_id"
  add_foreign_key "players", "pro_teams", column: "mlb_team_id"
  add_foreign_key "pro_ranking_players", "players"
  add_foreign_key "pro_ranking_players", "pro_ranking_sets", on_delete: :cascade
  add_foreign_key "season_batting_lines", "data_seasons"
  add_foreign_key "season_batting_lines", "players"
  add_foreign_key "season_pitching_lines", "data_seasons"
  add_foreign_key "season_pitching_lines", "players"
  add_foreign_key "user_player_articles", "user_players"
  add_foreign_key "user_players", "players"
  add_foreign_key "user_players", "users"
  add_foreign_key "user_ranking_players", "user_players"
  add_foreign_key "user_ranking_players", "user_ranking_sets", on_delete: :cascade
  add_foreign_key "user_ranking_sets", "users"
end
