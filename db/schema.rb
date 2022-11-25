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

ActiveRecord::Schema.define(version: 2022_11_25_024929) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "account_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bars", force: :cascade do |t|
    t.string "name", null: false
    t.integer "location", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "beer_styles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "beers", force: :cascade do |t|
    t.integer "beer_style_id", null: false
    t.integer "brewery_id", null: false
    t.string "name", null: false
    t.float "abv"
    t.float "ibu"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "evaluation"
    t.index ["beer_style_id"], name: "index_beers_on_beer_style_id"
    t.index ["brewery_id"], name: "index_beers_on_brewery_id"
    t.index ["name"], name: "index_beers_on_name", unique: true
  end

  create_table "breweries", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "location", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cheers", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id", "post_id"], name: "index_cheers_on_member_id_and_post_id", unique: true
    t.index ["member_id"], name: "index_cheers_on_member_id"
    t.index ["post_id"], name: "index_cheers_on_post_id"
  end

  create_table "group_post_comments", force: :cascade do |t|
    t.integer "group_post_id", null: false
    t.integer "member_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_post_id"], name: "index_group_post_comments_on_group_post_id"
    t.index ["member_id"], name: "index_group_post_comments_on_member_id"
  end

  create_table "group_posts", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "member_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_posts_on_group_id"
    t.index ["member_id"], name: "index_group_posts_on_member_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_groups_on_owner_id"
  end

  create_table "groups_members", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "member_id"], name: "index_groups_members_on_group_id_and_member_id", unique: true
    t.index ["group_id"], name: "index_groups_members_on_group_id"
    t.index ["member_id"], name: "index_groups_members_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "account_name", null: false
    t.string "display_name", null: false
    t.date "date_of_birth", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "introduction"
    t.integer "my_beer_style1_id"
    t.integer "my_beer_style2_id"
    t.integer "my_beer_style3_id"
    t.integer "my_beer_style4_id"
    t.index ["account_name"], name: "index_members_on_account_name", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["my_beer_style1_id"], name: "index_members_on_my_beer_style1_id"
    t.index ["my_beer_style2_id"], name: "index_members_on_my_beer_style2_id"
    t.index ["my_beer_style3_id"], name: "index_members_on_my_beer_style3_id"
    t.index ["my_beer_style4_id"], name: "index_members_on_my_beer_style4_id"
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "post_comments", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "post_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_post_comments_on_member_id"
    t.index ["post_id"], name: "index_post_comments_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "beer_id", null: false
    t.integer "bar_id"
    t.integer "shop_id"
    t.text "content"
    t.float "evaluation"
    t.integer "serving_style", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bar_id"], name: "index_posts_on_bar_id"
    t.index ["beer_id"], name: "index_posts_on_beer_id"
    t.index ["member_id"], name: "index_posts_on_member_id"
    t.index ["shop_id"], name: "index_posts_on_shop_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "follow_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["member_id", "follow_id"], name: "index_relationships_on_member_id_and_follow_id", unique: true
    t.index ["member_id"], name: "index_relationships_on_member_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", null: false
    t.integer "location", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beers", "beer_styles"
  add_foreign_key "beers", "breweries"
  add_foreign_key "cheers", "members"
  add_foreign_key "cheers", "posts"
  add_foreign_key "group_post_comments", "group_posts"
  add_foreign_key "group_post_comments", "members"
  add_foreign_key "group_posts", "groups"
  add_foreign_key "group_posts", "members"
  add_foreign_key "groups", "members", column: "owner_id"
  add_foreign_key "groups_members", "groups"
  add_foreign_key "groups_members", "members"
  add_foreign_key "members", "beer_styles", column: "my_beer_style1_id"
  add_foreign_key "members", "beer_styles", column: "my_beer_style2_id"
  add_foreign_key "members", "beer_styles", column: "my_beer_style3_id"
  add_foreign_key "members", "beer_styles", column: "my_beer_style4_id"
  add_foreign_key "post_comments", "members"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "posts", "bars"
  add_foreign_key "posts", "beers"
  add_foreign_key "posts", "members"
  add_foreign_key "posts", "shops"
  add_foreign_key "relationships", "members"
  add_foreign_key "relationships", "members", column: "follow_id"
end
