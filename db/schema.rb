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

ActiveRecord::Schema.define(version: 20161214183220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "mailgun_events", force: :cascade do |t|
    t.integer  "message_id", null: false
    t.integer  "event",      null: false
    t.string   "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_mailgun_events_on_message_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",                  null: false
    t.citext   "mailgun_id"
    t.integer  "message_type", default: 0, null: false
    t.citext   "subject"
    t.citext   "content"
    t.datetime "opened_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.citext   "name",                             null: false
    t.citext   "email",                            null: false
    t.string   "token",                            null: false
    t.boolean  "is_suppressed",    default: false, null: false
    t.datetime "invited_at",                       null: false
    t.datetime "reminder_sent_at"
    t.datetime "activated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["token"], name: "index_users_on_token", using: :btree
  end

end
