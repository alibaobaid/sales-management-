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

ActiveRecord::Schema.define(version: 2019_05_11_085640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assistants", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "for_him"
    t.integer "to_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_transfers", force: :cascade do |t|
    t.datetime "date_of_transfer"
    t.string "transfer_type"
    t.string "section_type"
    t.bigint "delegate_id"
    t.bigint "marketer_id"
    t.bigint "manger_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delegate_id"], name: "index_bank_transfers_on_delegate_id"
    t.index ["manger_id"], name: "index_bank_transfers_on_manger_id"
    t.index ["marketer_id"], name: "index_bank_transfers_on_marketer_id"
  end

  create_table "delegates", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "amount_of_box"
    t.integer "amount_of_gallon"
    t.integer "for_him"
    t.integer "to_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "commodity_type"
    t.integer "commodity_amount"
    t.datetime "delivery_time"
    t.bigint "delegate_id"
    t.index ["delegate_id"], name: "index_deliveries_on_delegate_id"
  end

  create_table "manger_discounts", force: :cascade do |t|
    t.bigint "manger_id"
    t.string "Desc"
    t.integer "value"
    t.date "date_of_discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manger_id"], name: "index_manger_discounts_on_manger_id"
  end

  create_table "mangers", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "for_him"
    t.integer "to_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marketers", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "phone_NO"
    t.integer "for_him"
    t.integer "to_him"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_operations", force: :cascade do |t|
    t.date "date", null: false
    t.string "commodity_type", null: false
    t.integer "commodity_amount", null: false
    t.float "price", null: false
    t.float "delegate_commission", null: false
    t.float "marketer_commission", null: false
    t.bigint "delegate_id", null: false
    t.bigint "marketer_id", null: false
    t.bigint "manger_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delegate_id"], name: "index_sales_operations_on_delegate_id"
    t.index ["manger_id"], name: "index_sales_operations_on_manger_id"
    t.index ["marketer_id"], name: "index_sales_operations_on_marketer_id"
  end

  add_foreign_key "bank_transfers", "delegates"
  add_foreign_key "bank_transfers", "mangers"
  add_foreign_key "bank_transfers", "marketers"
  add_foreign_key "deliveries", "delegates"
  add_foreign_key "manger_discounts", "mangers"
  add_foreign_key "sales_operations", "delegates"
  add_foreign_key "sales_operations", "mangers"
  add_foreign_key "sales_operations", "marketers"
end
