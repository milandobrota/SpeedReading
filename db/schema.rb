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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120701041111) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["content_id"], :name => "index_categorizations_on_content_id"

  create_table "contents", :force => true do |t|
    t.text     "body"
    t.string   "source_name"
    t.string   "source_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "language_id"
    t.string   "name"
  end

  add_index "contents", ["language_id"], :name => "index_contents_on_language_id"

  create_table "flash_reading_tests", :force => true do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "word_throughput"
    t.integer  "reading_speed"
  end

  add_index "flash_reading_tests", ["content_id"], :name => "index_flash_reading_tests_on_content_id"
  add_index "flash_reading_tests", ["user_id"], :name => "index_flash_reading_tests_on_user_id"

  create_table "flashing_numbers_tests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flashing_numbers_tests", ["user_id"], :name => "index_flashing_numbers_tests_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.text     "body"
    t.text     "answers"
    t.integer  "content_id"
    t.integer  "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["content_id"], :name => "index_questions_on_content_id"

  create_table "reading_speed_tests", :force => true do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.integer  "wpm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comprehension_rate"
  end

  add_index "reading_speed_tests", ["content_id"], :name => "index_reading_speed_tests_on_content_id"
  add_index "reading_speed_tests", ["user_id"], :name => "index_reading_speed_tests_on_user_id"

  create_table "scrambled_word_tests", :force => true do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.integer  "wpm"
    t.integer  "comprehension_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scrambled_word_tests", ["content_id"], :name => "index_scrambled_word_tests_on_content_id"
  add_index "scrambled_word_tests", ["user_id"], :name => "index_scrambled_word_tests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "word_search_tests", :force => true do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_search_tests", ["content_id"], :name => "index_word_search_tests_on_content_id"
  add_index "word_search_tests", ["user_id"], :name => "index_word_search_tests_on_user_id"

end
