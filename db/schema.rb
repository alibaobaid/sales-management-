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

ActiveRecord::Schema.define(version: 2019_11_03_061715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "value"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "assistants", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "his_amount"
    t.float "for_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_assistants_on_country_id"
  end

  create_table "bank_transfers", force: :cascade do |t|
    t.datetime "date_of_transfer"
    t.string "transfer_type"
    t.string "section_type"
    t.bigint "delegate_id"
    t.bigint "assistant_id"
    t.bigint "marketer_id"
    t.bigint "manger_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.string "note"
    t.bigint "bank_id"
    t.index ["assistant_id"], name: "index_bank_transfers_on_assistant_id"
    t.index ["bank_id"], name: "index_bank_transfers_on_bank_id"
    t.index ["country_id"], name: "index_bank_transfers_on_country_id"
    t.index ["delegate_id"], name: "index_bank_transfers_on_delegate_id"
    t.index ["manger_id"], name: "index_bank_transfers_on_manger_id"
    t.index ["marketer_id"], name: "index_bank_transfers_on_marketer_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.float "balance", default: 0.0
    t.string "desc"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_banks_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "delegates", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "amount_of_box", default: 0
    t.integer "amount_of_gallon", default: 0
    t.float "for_him", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_delegates_on_country_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "commodity_type"
    t.integer "commodity_amount"
    t.datetime "delivery_time"
    t.bigint "delegate_id"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_deliveries_on_country_id"
    t.index ["delegate_id"], name: "index_deliveries_on_delegate_id"
  end

  create_table "external_employees", force: :cascade do |t|
    t.string "name"
    t.float "for_him"
    t.string "phone_NO"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_external_employees_on_country_id"
  end

  create_table "external_transfers", force: :cascade do |t|
    t.date "date_of_transfer"
    t.string "sender_type"
    t.bigint "sender_id"
    t.string "receiver_type"
    t.bigint "receiver_id"
    t.bigint "country_id"
    t.float "price"
    t.index ["country_id"], name: "index_external_transfers_on_country_id"
    t.index ["receiver_type", "receiver_id"], name: "index_external_transfers_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_external_transfers_on_sender_type_and_sender_id"
  end

  create_table "manger_discounts", force: :cascade do |t|
    t.bigint "manger_id"
    t.string "Desc"
    t.float "value"
    t.date "date_of_discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.bigint "bank_id"
    t.index ["bank_id"], name: "index_manger_discounts_on_bank_id"
    t.index ["country_id"], name: "index_manger_discounts_on_country_id"
    t.index ["manger_id"], name: "index_manger_discounts_on_manger_id"
  end

  create_table "mangers", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.float "for_him"
    t.float "to_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.float "final_manager_amount", default: 0.0, null: false
    t.index ["country_id"], name: "index_mangers_on_country_id"
  end

  create_table "marketers", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.float "for_him", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_marketers_on_country_id"
  end

  create_table "product_discounts", force: :cascade do |t|
    t.string "product_type"
    t.string "reason"
    t.integer "amount"
    t.date "discount_date"
    t.bigint "delegate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_product_discounts_on_country_id"
    t.index ["delegate_id"], name: "index_product_discounts_on_delegate_id"
  end

  create_table "sales_operations", force: :cascade do |t|
    t.date "date", null: false
    t.float "price", null: false
    t.float "delegate_commission", null: false
    t.float "marketer_commission", null: false
    t.float "from_delegate_transfer"
    t.float "to_marketer_transfer"
    t.float "to_manger_transfer"
    t.bigint "delegate_id", null: false
    t.bigint "marketer_id", null: false
    t.bigint "manger_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operation_number"
    t.string "customr_no"
    t.string "customr_city"
    t.bigint "country_id"
    t.float "manager_commission", default: 0.0, null: false
    t.integer "gallon_amount", default: 0, null: false
    t.integer "box_amount", default: 0, null: false
    t.float "final_manager_amount", default: 0.0, null: false
    t.float "exchange_for_delegator", default: 0.0
    t.float "exchange_for_marketer", default: 0.0
    t.index ["country_id"], name: "index_sales_operations_on_country_id"
    t.index ["delegate_id"], name: "index_sales_operations_on_delegate_id"
    t.index ["manger_id"], name: "index_sales_operations_on_manger_id"
    t.index ["marketer_id"], name: "index_sales_operations_on_marketer_id"
    t.index ["operation_number"], name: "index_sales_operations_on_operation_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "role_type", default: "مدير", null: false
    t.boolean "is_default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["password_digest"], name: "index_users_on_password_digest"
    t.index ["role_type"], name: "index_users_on_role_type"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "assistants", "countries"
  add_foreign_key "bank_transfers", "assistants"
  add_foreign_key "bank_transfers", "banks"
  add_foreign_key "bank_transfers", "countries"
  add_foreign_key "bank_transfers", "delegates"
  add_foreign_key "bank_transfers", "mangers"
  add_foreign_key "bank_transfers", "marketers"
  add_foreign_key "banks", "countries"
  add_foreign_key "delegates", "countries"
  add_foreign_key "deliveries", "countries"
  add_foreign_key "deliveries", "delegates"
  add_foreign_key "external_employees", "countries"
  add_foreign_key "external_transfers", "countries"
  add_foreign_key "manger_discounts", "banks"
  add_foreign_key "manger_discounts", "countries"
  add_foreign_key "manger_discounts", "mangers"
  add_foreign_key "mangers", "countries"
  add_foreign_key "marketers", "countries"
  add_foreign_key "product_discounts", "countries"
  add_foreign_key "product_discounts", "delegates"
  add_foreign_key "sales_operations", "countries"
  add_foreign_key "sales_operations", "delegates"
  add_foreign_key "sales_operations", "mangers"
  add_foreign_key "sales_operations", "marketers"
  add_foreign_key "users", "countries"
end
