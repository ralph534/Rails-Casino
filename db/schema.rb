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

ActiveRecord::Schema.define(version: 20180414001653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blackjack_games", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wager", default: 1
    t.string "winner"
    t.index ["game_id"], name: "index_blackjack_games_on_game_id"
    t.index ["user_id"], name: "index_blackjack_games_on_user_id"
  end

  create_table "blackjack_hands", force: :cascade do |t|
    t.bigint "blackjack_game_id"
    t.integer "card1_id"
    t.integer "card2_id"
    t.string "holder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wager"
    t.integer "value"
    t.integer "card3_id"
    t.integer "card4_id"
    t.integer "card5_id"
    t.integer "card6_id"
    t.integer "card7_id"
    t.index ["blackjack_game_id"], name: "index_blackjack_hands_on_blackjack_game_id"
  end

  create_table "blackjack_moves", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "stay"
    t.bigint "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "blackjack_hand_id"
    t.index ["blackjack_hand_id"], name: "index_blackjack_moves_on_blackjack_hand_id"
    t.index ["card_id"], name: "index_blackjack_moves_on_card_id"
    t.index ["user_id"], name: "index_blackjack_moves_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "rank"
    t.string "suit"
    t.integer "value"
    t.integer "straight_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_id"
    t.integer "requested_id"
    t.boolean "accepted", default: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
    t.index ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true
    t.index ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "poker_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.boolean "computer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poker_games", force: :cascade do |t|
    t.integer "player1"
    t.integer "player2"
    t.integer "player3"
    t.integer "player4"
    t.integer "player5"
    t.integer "player6"
    t.integer "player7"
    t.integer "player8"
    t.integer "pot"
    t.integer "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "poker_room_id"
  end

  create_table "poker_hands", force: :cascade do |t|
    t.bigint "poker_round_id"
    t.integer "card1_id"
    t.integer "card2_id"
    t.bigint "user_id"
    t.integer "wager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poker_round_id"], name: "index_poker_hands_on_poker_round_id"
    t.index ["user_id"], name: "index_poker_hands_on_user_id"
  end

  create_table "poker_moves", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "poker_game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "betting_round"
    t.string "move"
    t.index ["poker_game_id"], name: "index_poker_moves_on_poker_game_id"
    t.index ["user_id"], name: "index_poker_moves_on_user_id"
  end

  create_table "poker_rooms", force: :cascade do |t|
    t.integer "player_count"
    t.integer "player1"
    t.integer "player2"
    t.integer "player3"
    t.integer "player4"
    t.integer "player5"
    t.integer "player6"
    t.integer "player7"
    t.integer "player8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_round"
  end

  create_table "private_messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "balance"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "channel_key"
    t.boolean "online"
    t.string "remember_digest"
    t.integer "current_room"
    t.bigint "game_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["game_id"], name: "index_users_on_game_id"
  end

  add_foreign_key "blackjack_games", "games"
  add_foreign_key "blackjack_games", "users"
  add_foreign_key "blackjack_hands", "blackjack_games"
  add_foreign_key "blackjack_moves", "blackjack_hands"
  add_foreign_key "blackjack_moves", "cards"
  add_foreign_key "blackjack_moves", "users"
  add_foreign_key "poker_hands", "poker_games", column: "poker_round_id"
  add_foreign_key "poker_hands", "users"
  add_foreign_key "poker_moves", "poker_games"
  add_foreign_key "poker_moves", "users"
  add_foreign_key "users", "games"
end
