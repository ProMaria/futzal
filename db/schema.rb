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

ActiveRecord::Schema.define(version: 2019_01_16_190326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ampluas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docs", force: :cascade do |t|
    t.string "filename"
    t.string "content_type"
    t.binary "file_contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schedule_id"
  end

  create_table "goal_leaders", force: :cascade do |t|
    t.bigint "team_id"
    t.string "fio"
    t.integer "goal"
    t.index ["team_id"], name: "index_goal_leaders_on_team_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "body_preview"
    t.text "body"
    t.integer "count_views", default: 0
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "tour_id"
    t.index ["tour_id"], name: "index_photos_on_tour_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "fi"
    t.bigint "amplua_id"
    t.string "year"
    t.bigint "team_id"
    t.index ["amplua_id"], name: "index_players_on_amplua_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "referees", force: :cascade do |t|
    t.string "fio"
    t.string "city"
    t.string "category"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "timestamp"
    t.string "result"
    t.integer "home_team_id"
    t.integer "guest_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "summary"
    t.integer "tour_id"
  end

  create_table "table_results", force: :cascade do |t|
    t.bigint "league_id"
    t.bigint "team_id"
    t.integer "count_game"
    t.integer "count_win"
    t.integer "count_pat"
    t.integer "count_lost"
    t.integer "count_ball_create"
    t.integer "count_ball_lost"
    t.integer "sub_ball"
    t.integer "score"
    t.integer "place"
    t.index ["league_id"], name: "index_table_results_on_league_id"
    t.index ["team_id"], name: "index_table_results_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "active_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
