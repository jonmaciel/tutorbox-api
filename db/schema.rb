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

ActiveRecord::Schema.define(version: 20180303032443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "source_type", null: false
    t.bigint "source_id", null: false
    t.bigint "created_by_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_attachments_on_created_by_id"
    t.index ["deleted_at"], name: "index_attachments_on_deleted_at"
    t.index ["source_type", "source_id"], name: "index_attachments_on_source_type_and_source_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "author_id", null: false
    t.integer "comment_destination", null: false
    t.string "body"
    t.boolean "read", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at"
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
    t.string "name", null: false
    t.bigint "organization_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_systems_on_deleted_at"
    t.index ["organization_id"], name: "index_systems_on_organization_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "done", default: false, null: false
    t.bigint "video_id", null: false
    t.bigint "created_by_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["deleted_at"], name: "index_tasks_on_deleted_at"
    t.index ["video_id"], name: "index_tasks_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "system_id"
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "user_role", null: false
    t.string "cellphone"
    t.string "facebook_url"
    t.json "system_role_params"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["password_digest"], name: "index_users_on_password_digest"
    t.index ["system_id"], name: "index_users_on_system_id"
  end

  create_table "users_videos", id: false, force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "user_id"
    t.index ["user_id", "video_id"], name: "index_users_videos_on_user_id_and_video_id"
    t.index ["user_id"], name: "index_users_videos_on_user_id"
    t.index ["video_id", "user_id"], name: "index_users_videos_on_video_id_and_user_id"
    t.index ["video_id"], name: "index_users_videos_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.integer "version", default: 0
    t.string "url"
    t.string "aasm_state"
    t.json "labels"
    t.bigint "system_id", null: false
    t.bigint "created_by_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_videos_on_created_by_id"
    t.index ["deleted_at"], name: "index_videos_on_deleted_at"
    t.index ["system_id"], name: "index_videos_on_system_id"
  end

  add_foreign_key "attachments", "users", column: "created_by_id"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "comments", "videos"
  add_foreign_key "state_histories", "videos"
  add_foreign_key "systems", "organizations"
  add_foreign_key "tasks", "users", column: "created_by_id"
  add_foreign_key "tasks", "videos"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "systems"
  add_foreign_key "users_videos", "users"
  add_foreign_key "users_videos", "videos"
  add_foreign_key "videos", "systems"
  add_foreign_key "videos", "users", column: "created_by_id"
end
