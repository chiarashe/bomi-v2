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

ActiveRecord::Schema[7.1].define(version: 2024_02_08_232128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.string "link_video"
    t.string "content_type"
    t.string "theme_type"
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_contents_on_doctor_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_birth"
    t.string "location"
    t.string "phone_number"
    t.string "profession"
    t.string "cedula_profesional"
    t.string "curp"
    t.string "studies"
    t.index ["email"], name: "index_doctors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true
  end

  create_table "patients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_birth"
    t.string "location"
    t.string "phone_number"
    t.string "link"
    t.string "goal"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "answer"
    t.bigint "report_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_questions_on_report_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "title"
    t.string "comments"
    t.string "link_content"
    t.boolean "done"
    t.bigint "report_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_recommendations_on_doctor_id"
    t.index ["report_id"], name: "index_recommendations_on_report_id"
  end

  create_table "relations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_relations_on_doctor_id"
    t.index ["patient_id"], name: "index_relations_on_patient_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_reports_on_patient_id"
  end

  add_foreign_key "contents", "doctors"
  add_foreign_key "questions", "reports"
  add_foreign_key "recommendations", "doctors"
  add_foreign_key "recommendations", "reports"
  add_foreign_key "relations", "doctors"
  add_foreign_key "relations", "patients"
  add_foreign_key "reports", "patients"
end
