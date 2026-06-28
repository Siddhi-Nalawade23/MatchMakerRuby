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

ActiveRecord::Schema[8.1].define(version: 2026_06_22_075552) do
  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "price"
    t.integer "shop_id", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "singles", force: :cascade do |t|
    t.bigint "age"
    t.text "broker_number"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.text "gender"
    t.string "last_name"
    t.string "phone"
    t.text "status"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_singles_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "email"
    t.string "encrypted_password", default: "", null: false
    t.text "name"
    t.text "otp"
    t.datetime "otp_created_at"
    t.datetime "otp_expires_at"
    t.boolean "otp_used", default: false
    t.text "phone"
    t.string "provider"
    t.text "refresh_token"
    t.datetime "refresh_token_expiry"
    t.text "role", default: "admin"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "products", "shops"
  add_foreign_key "singles", "users"
end
