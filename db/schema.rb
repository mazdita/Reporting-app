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

ActiveRecord::Schema.define(version: 2022_06_26_162205) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "client_costs", force: :cascade do |t|
    t.string "client"
    t.string "month"
    t.decimal "cost", precision: 25, scale: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "report_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_comments_on_admin_id"
    t.index ["report_id"], name: "index_comments_on_report_id"
  end

  create_table "placements", force: :cascade do |t|
    t.string "client_name"
    t.string "worker_first_name"
    t.string "job_function"
    t.date "start_date"
    t.date "end_date"
    t.decimal "monthly_salary", precision: 25, scale: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "placement_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "client"
    t.date "month"
    t.integer "total_cost"
    t.string "job_requests_names"
    t.string "job_requests_costs"
    t.index ["admin_id"], name: "index_reports_on_admin_id"
  end

  add_foreign_key "comments", "admins"
  add_foreign_key "comments", "reports"
  add_foreign_key "reports", "admins"
end
