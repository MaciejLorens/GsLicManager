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

ActiveRecord::Schema.define(version: 2018_10_17_124026) do

  # create_table "app_versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  #   t.string "value"
  #   t.integer "version_no"
  #   t.boolean "is_deleted"
  #   t.boolean "is_active"
  #   t.bigint "app_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["app_id"], name: "index_app_versions_on_app_id"
  # end

  # create_table "apps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  #   t.string "name_app"
  #   t.boolean "is_deleted"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  create_table "configs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key"
    t.string "value_str1"
    t.string "value_str2"
    t.string "value_str3"
    t.string "value_str4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  # create_table "license_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  #   t.string "val_pl"
  #   t.string "val_en"
  #   t.integer "is_deleted", default: 0
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  create_table "tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_valid"
  end

  create_table "user_apps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "app_id"
    t.boolean "is_deleted"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_user_apps_on_app_id"
    t.index ["user_id"], name: "index_user_apps_on_user_id"
  end

  create_table "user_licenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "app_id"
    t.bigint "app_version_id"
    t.string "version_no"                 # duplication from app_verison
    t.integer "scales_amount"             # whats that
    t.integer "license_type_id"
    t.string "old_app_code"               # whats that
    t.string "end_client_desc"            # moved to end_client_name and end_client_address
    t.string "description"
    t.string "new_app_code"               # is it registration_key or unlock_key
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["app_id"], name: "index_user_licenses_on_app_id"
    t.index ["app_version_id"], name: "index_user_licenses_on_app_version_id"
  end

  # create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  #   t.string "email", default: "", null: false
  #   t.string "encrypted_password", default: "", null: false
  #   t.string "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.integer "sign_in_count", default: 0, null: false
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.string "current_sign_in_ip"
  #   t.string "last_sign_in_ip"
  #   t.integer "failed_attempts", default: 0, null: false
  #   t.string "unlock_token"
  #   t.datetime "locked_at"
  #   t.string "first_name"
  #   t.string "last_name"
  #   t.boolean "hidden", default: false, null: false
  #   t.datetime "hidden_at"
  #   t.string "company_name"
  #   t.string "send_to"
  #   t.string "pref_lang"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.integer "limit"
  #   t.integer "current_limit"
  #   t.date "limit_change_date"
  #   t.integer "is_blocked", default: 0
  #   t.integer "is_active", default: 1
  #   t.datetime "block_date"
  #   t.integer "block_counter", default: 0
  #   t.index ["email"], name: "index_users_on_email", unique: true
  #   t.index ["hidden"], name: "index_users_on_hidden"
  #   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  #   t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  # end

  # add_foreign_key "app_versions", "apps"
  # add_foreign_key "user_apps", "apps"
  # add_foreign_key "user_apps", "users"
  # add_foreign_key "user_licenses", "app_versions"
  # add_foreign_key "user_licenses", "apps"
end
