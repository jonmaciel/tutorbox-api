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

ActiveRecord::Schema.define(version: 20180217221734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "source_type"
    t.bigint "source_id"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_attachments_on_created_by_id"
    t.index ["source_type", "source_id"], name: "index_attachments_on_source_type_and_source_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "author_id"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.index ["organization_id", "user_id"], name: "index_organizations_users_on_organization_id_and_user_id"
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_organizations_users_on_user_id_and_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "state_histories", force: :cascade do |t|
    t.bigint "video_id"
    t.string "from_state"
    t.string "to_state"
    t.string "current_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_state_histories_on_video_id"
  end

  create_table "systems", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_systems_on_organization_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.bigint "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_tasks_on_video_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "user_role_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["password_digest"], name: "index_users_on_password_digest"
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  create_table "video_labels", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "url"
    t.string "aasm_state"
    t.json "labels"
    t.bigint "system_id"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_videos_on_created_by_id"
    t.index ["system_id"], name: "index_videos_on_system_id"
  end

  add_foreign_key "attachments", "users", column: "created_by_id"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "comments", "videos"
  add_foreign_key "organizations_users", "organizations"
  add_foreign_key "organizations_users", "users"
  add_foreign_key "state_histories", "videos"
  add_foreign_key "systems", "organizations"
  add_foreign_key "tasks", "videos"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "user_roles"
  add_foreign_key "videos", "systems"
  add_foreign_key "videos", "users", column: "created_by_id"
end
