# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_23_224024) do
  create_table "brands", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.string "hash_name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_name"], name: "index_brands_on_hash_name", unique: true
  end

  create_table "calibers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active"
    t.string "hash_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_name"], name: "index_calibers_on_hash_name", unique: true
  end

  create_table "weapons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "serie_number", null: false
    t.string "model"
    t.bigint "caliber_id", null: false
    t.bigint "brand_id", null: false
    t.boolean "active", default: true, null: false
    t.string "system_register", default: "sigma", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number_craf", null: false
    t.string "bore", null: false
    t.string "bore_direction"
    t.string "weapon_type", null: false
    t.index ["brand_id"], name: "index_weapons_on_brand_id"
    t.index ["caliber_id"], name: "index_weapons_on_caliber_id"
    t.index ["serie_number"], name: "index_weapons_on_serie_number", unique: true
    t.check_constraint "`bore` in (_utf8mb4'RAIADA',_utf8mb4'LISA')", name: "bore_check_values"
  end

  add_foreign_key "weapons", "brands"
  add_foreign_key "weapons", "calibers"
end
