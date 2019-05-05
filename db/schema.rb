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

ActiveRecord::Schema.define(version: 2019_04_27_115349) do

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

  create_table "operations", force: :cascade do |t|
    t.datetime "date_of_sale"
    t.bigint "delegates_id"
    t.string "product_type"
    t.integer "amount"
    t.integer "the_value"
    t.integer "delegate_value"
    t.bigint "marketers_id"
    t.integer "marketer_value"
    t.bigint "mangers_id"
    t.integer "manger_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delegates_id"], name: "index_operations_on_delegates_id"
    t.index ["mangers_id"], name: "index_operations_on_mangers_id"
    t.index ["marketers_id"], name: "index_operations_on_marketers_id"
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

  add_foreign_key "deliveries", "delegates"
  add_foreign_key "operations", "delegates", column: "delegates_id"
  add_foreign_key "operations", "mangers", column: "mangers_id"
  add_foreign_key "operations", "marketers", column: "marketers_id"
  add_foreign_key "sales_operations", "delegates"
  add_foreign_key "sales_operations", "mangers"
  add_foreign_key "sales_operations", "marketers"
end
