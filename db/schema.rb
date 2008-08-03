# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 10) do

  create_table "brigades", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "membership_size"
    t.string   "website_url"
    t.date     "established_on"
    t.string   "city"
    t.string   "state_region"
    t.string   "country"
    t.string   "postal_code"
    t.decimal  "lat",             :precision => 15, :scale => 10
    t.decimal  "lng",             :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "feed_items", :force => true do |t|
    t.string   "summary"
    t.text     "description"
    t.string   "uri"
    t.text     "location"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id",      :null => false
    t.string   "guid"
    t.datetime "published_at"
  end

  add_index "feed_items", ["feed_id"], :name => "index_feed_items_on_feed_id"

  create_table "feeds", :force => true do |t|
    t.string   "uri"
    t.datetime "last_checked_at"
    t.integer  "brigade_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

end
