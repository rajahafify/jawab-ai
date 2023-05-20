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

ActiveRecord::Schema[7.0].define(version: 2023_05_20_041359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "containers", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "factory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factory_id"], name: "index_containers_on_factory_id"
  end

  create_table "entries", force: :cascade do |t|
    t.text "content"
    t.bigint "container_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.index ["container_id"], name: "index_entries_on_container_id"
  end

  create_table "factories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_factories_on_name", unique: true
    t.index ["url"], name: "index_factories_on_url", unique: true
  end

  add_foreign_key "containers", "factories"
  add_foreign_key "entries", "containers"
end
