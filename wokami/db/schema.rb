# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141106123309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.string  "content"
    t.integer "question_id"
    t.float   "weight",           default: 1.0
    t.integer "next_question_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "answers_tags", force: true do |t|
    t.integer "answer_id"
    t.string  "tag"
    t.float   "weight"
  end

  add_index "answers_tags", ["answer_id"], name: "index_answers_tags_on_answer_id", using: :btree

  create_table "chapters", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chapter_type"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "flow_answers", force: true do |t|
    t.integer "answer_id"
    t.integer "flow_id"
  end

  add_index "flow_answers", ["answer_id"], name: "index_flow_answers_on_answer_id", using: :btree
  add_index "flow_answers", ["flow_id"], name: "index_flow_answers_on_flow_id", using: :btree

  create_table "flow_chapters", force: true do |t|
    t.integer "flow_id"
    t.integer "chapter_id"
    t.integer "order"
  end

  add_index "flow_chapters", ["chapter_id"], name: "index_flow_chapters_on_chapter_id", using: :btree
  add_index "flow_chapters", ["flow_id"], name: "index_flow_chapters_on_flow_id", using: :btree

  create_table "flows", force: true do |t|
    t.integer "subject_id"
    t.integer "score",      default: 1
    t.string  "name"
    t.integer "user_id"
  end

  add_index "flows", ["subject_id"], name: "index_flows_on_subject_id", using: :btree

  create_table "flows_tags", force: true do |t|
    t.integer "flows_id"
    t.integer "tag_id"
    t.float   "weight",   default: 1.0
  end

  add_index "flows_tags", ["flows_id"], name: "index_flows_tags_on_flows_id", using: :btree
  add_index "flows_tags", ["tag_id"], name: "index_flows_tags_on_tag_id", using: :btree

  create_table "interests", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "next_question", force: true do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.integer "next_question_id"
  end

  add_index "next_question", ["answer_id"], name: "index_next_question_on_answer_id", using: :btree
  add_index "next_question", ["question_id"], name: "index_next_question_on_question_id", using: :btree

  create_table "points", force: true do |t|
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.integer  "size",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_answers", force: true do |t|
    t.integer "answer_id"
    t.integer "post_id"
  end

  add_index "post_answers", ["answer_id"], name: "index_post_answers_on_answer_id", using: :btree
  add_index "post_answers", ["post_id"], name: "index_post_answers_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.integer  "points"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
    t.text     "image"
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.string   "description"
    t.string   "minutes"
    t.string   "media_type"
    t.string   "user"
    t.text     "details"
    t.string   "image_style"
    t.string   "background_color"
    t.string   "content_css_classes"
  end

  add_index "posts", ["chapter_id"], name: "index_posts_on_chapter_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "posts_tags", force: true do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts_tags", ["post_id"], name: "index_posts_tags_on_post_id", using: :btree
  add_index "posts_tags", ["tag_id"], name: "index_posts_tags_on_tag_id", using: :btree

  create_table "questions", force: true do |t|
    t.string  "content"
    t.boolean "is_multi"
    t.integer "subject_id"
    t.float   "weight",     default: 1.0
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "image"
    t.string   "subject_type"
    t.boolean  "setting_is_chapters"
    t.boolean  "setting_is_tags"
    t.boolean  "setting_is_resources"
    t.boolean  "setting_is_private"
    t.integer  "root_question_id"
    t.string   "image_css"
    t.string   "intro_page_titles_color"
    t.string   "background_color"
    t.boolean  "is_navigation"
    t.text     "intro_message_style"
    t.text     "general_style"
    t.boolean  "is_search"
  end

  create_table "tag_context", force: true do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
  end

  add_index "tag_context", ["subject_id"], name: "index_tag_context_on_subject_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "tag_context_id"
    t.integer "points"
  end

  create_table "user_flows", force: true do |t|
    t.integer "user_id"
    t.integer "flow_id"
    t.integer "subject_id"
  end

  add_index "user_flows", ["flow_id"], name: "index_user_flows_on_flow_id", using: :btree
  add_index "user_flows", ["user_id"], name: "index_user_flows_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "profile_image"
    t.string   "oauth_token"
    t.time     "oauth_expires_at"
    t.string   "name"
    t.string   "username"
    t.string   "role"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  create_table "users_answers", force: true do |t|
    t.integer "answer_id"
    t.integer "user_id"
    t.integer "subject_id"
  end

  add_index "users_answers", ["answer_id"], name: "index_users_answers_on_answer_id", using: :btree
  add_index "users_answers", ["subject_id"], name: "index_users_answers_on_subject_id", using: :btree
  add_index "users_answers", ["user_id"], name: "index_users_answers_on_user_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
