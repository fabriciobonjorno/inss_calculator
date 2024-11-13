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

ActiveRecord::Schema[7.2].define(version: 2024_11_13_153033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "zip_code"
    t.string "street"
    t.string "street_number"
    t.string "complement"
    t.string "state"
    t.string "city"
    t.string "neighborhood"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["city"], name: "index_addresses_on_city"
    t.index ["complement"], name: "index_addresses_on_complement"
    t.index ["neighborhood"], name: "index_addresses_on_neighborhood"
    t.index ["state"], name: "index_addresses_on_state"
    t.index ["street"], name: "index_addresses_on_street"
    t.index ["street_number"], name: "index_addresses_on_street_number"
    t.index ["zip_code"], name: "index_addresses_on_zip_code"
  end

  create_table "dash_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_dash_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_dash_users_on_reset_password_token", unique: true
  end

  create_table "phones", force: :cascade do |t|
    t.integer "kind"
    t.string "number"
    t.string "phoneble_type", null: false
    t.bigint "phoneble_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_phones_on_kind"
    t.index ["number"], name: "index_phones_on_number"
    t.index ["phoneble_type", "phoneble_id"], name: "index_phones_on_phoneble"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.date "birth_date"
    t.decimal "income", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "inss_value", precision: 10, scale: 2
    t.index ["birth_date"], name: "index_proponents_on_birth_date"
    t.index ["document"], name: "index_proponents_on_document", unique: true
    t.index ["income"], name: "index_proponents_on_income"
    t.index ["inss_value"], name: "index_proponents_on_inss_value"
    t.index ["name"], name: "index_proponents_on_name"
  end
end
