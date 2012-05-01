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

ActiveRecord::Schema.define(:version => 201203072147540) do

  create_table "battles", :force => true do |t|
    t.string   "attacker"
    t.string   "defenser"
    t.integer  "ftype"
    t.integer  "status"
    t.integer  "winner"
    t.text     "prop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", :force => true do |t|
    t.string   "eqname"
    t.string   "eqtype"
    t.string   "prop"
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "equipment", ["owner"], :name => "index_equipment_on_owner", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "dname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer  "owner"
    t.string   "code"
    t.integer  "power"
    t.text     "prop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tradables", :force => true do |t|
    t.string   "name"
    t.integer  "obtype"
    t.integer  "price"
    t.integer  "number"
    t.integer  "soldnum"
    t.integer  "owner"
    t.string   "ownername"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usereqs", :force => true do |t|
    t.integer  "uid"
    t.string   "sid"
    t.integer  "eqid"
    t.string   "eqname"
    t.integer  "eqslotnum"
    t.string   "wearon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userexts", :force => true do |t|
    t.integer  "uid"
    t.string   "name"
    t.integer  "gold"
    t.integer  "exp"
    t.integer  "level"
    t.text     "prop"
    t.string   "sid"
    t.integer  "hp"
    t.integer  "maxhp"
    t.integer  "stam"
    t.integer  "maxst"
    t.integer  "str"
    t.integer  "dext"
    t.integer  "luck"
    t.integer  "fame"
    t.string   "race"
    t.integer  "pot"
    t.integer  "it"
    t.integer  "jingli"
    t.integer  "max_jl"
    t.integer  "zhanyi",     :default => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lastact"
  end

  create_table "userquests", :force => true do |t|
    t.string   "sid"
    t.integer  "uid"
    t.string   "name"
    t.integer  "progress"
    t.text     "prop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userrsches", :force => true do |t|
    t.integer  "uid"
    t.string   "sid"
    t.string   "skname"
    t.integer  "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userrsches", ["uid", "sid", "skname"], :name => "idx1", :unique => true

  create_table "users", :force => true do |t|
    t.string   "user"
    t.string   "sid"
    t.integer  "age"
    t.integer  "race"
    t.integer  "sex"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile"
  end

  add_index "users", ["sid"], :name => "index_users_on_sid", :unique => true
  add_index "users", ["user"], :name => "index_users_on_user", :unique => true

  create_table "userskills", :force => true do |t|
    t.integer  "uid"
    t.string   "sid"
    t.integer  "skid"
    t.string   "skname"
    t.string   "skdname"
    t.integer  "level"
    t.integer  "tp"
    t.integer  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userskills", ["uid", "skname"], :name => "index_userskills_on_uid_and_skname", :unique => true

end
