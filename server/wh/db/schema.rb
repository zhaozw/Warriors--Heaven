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

ActiveRecord::Schema.define(:version => 20120629173416) do

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

  add_index "battles", ["attacker"], :name => "index_battles_on_attacker"
  add_index "battles", ["defenser"], :name => "index_battles_on_defenser"
  add_index "battles", ["ftype"], :name => "index_battles_on_ftype"
  add_index "battles", ["status"], :name => "index_battles_on_status"
  add_index "battles", ["updated_at"], :name => "index_battles_on_updated_at"
  add_index "battles", ["winner"], :name => "index_battles_on_winner"

  create_table "equipment", :force => true do |t|
    t.string   "eqname"
    t.string   "eqtype"
    t.string   "prop"
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "equipment", ["owner"], :name => "index_equipment_on_owner"

  create_table "globalquests", :force => true do |t|
    t.string   "name"
    t.integer  "stat"
    t.text     "prop"
    t.datetime "finishedat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iapkeys", :force => true do |t|
    t.integer  "uid"
    t.string   "sid"
    t.string   "key"
    t.string   "tid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "iapkeys", ["tid"], :name => "index_iapkeys_on_tid", :unique => true

  create_table "ranks", :force => true do |t|
    t.integer  "uid"
    t.integer  "c0"
    t.integer  "c1"
    t.integer  "c2"
    t.integer  "c3"
    t.integer  "c4"
    t.integer  "c5"
    t.integer  "c6"
    t.integer  "c7"
    t.integer  "c8"
    t.integer  "c9"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["c0"], :name => "index_ranks_on_c0"
  add_index "ranks", ["c1"], :name => "index_ranks_on_c1"
  add_index "ranks", ["c2"], :name => "index_ranks_on_c2"
  add_index "ranks", ["c3"], :name => "index_ranks_on_c3"
  add_index "ranks", ["c4"], :name => "index_ranks_on_c4"
  add_index "ranks", ["c5"], :name => "index_ranks_on_c5"
  add_index "ranks", ["c6"], :name => "index_ranks_on_c6"
  add_index "ranks", ["c7"], :name => "index_ranks_on_c7"
  add_index "ranks", ["c8"], :name => "index_ranks_on_c8"
  add_index "ranks", ["c9"], :name => "index_ranks_on_c9"
  add_index "ranks", ["uid"], :name => "index_ranks_on_uid", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
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

  add_index "teams", ["code"], :name => "index_teams_on_code", :unique => true
  add_index "teams", ["owner"], :name => "index_teams_on_owner", :unique => true
  add_index "teams", ["power"], :name => "index_teams_on_power"

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

  add_index "tradables", ["name"], :name => "index_tradables_on_name", :unique => true

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

  add_index "usereqs", ["sid"], :name => "index_usereqs_on_sid", :unique => true
  add_index "usereqs", ["uid"], :name => "index_usereqs_on_uid", :unique => true

  create_table "userexts", :force => true do |t|
    t.integer  "uid"
    t.string   "name"
    t.integer  "gold"
    t.integer  "exp"
    t.integer  "level"
    t.string   "lastact"
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
    t.string   "sstatus"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shen",       :default => 100
  end

  add_index "userexts", ["gold"], :name => "index_userexts_on_gold"
  add_index "userexts", ["level"], :name => "index_userexts_on_level"
  add_index "userexts", ["shen"], :name => "index_userexts_on_shen"
  add_index "userexts", ["sid"], :name => "index_userexts_on_sid", :unique => true
  add_index "userexts", ["uid"], :name => "index_userexts_on_uid", :unique => true

  create_table "userquests", :force => true do |t|
    t.string   "sid"
    t.integer  "uid"
    t.string   "name"
    t.integer  "progress"
    t.integer  "count"
    t.text     "prop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userquests", ["uid"], :name => "index_userquests_on_uid"

  create_table "userrsches", :force => true do |t|
    t.integer  "uid"
    t.string   "sid"
    t.string   "skname"
    t.integer  "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userrsches", ["uid", "sid", "skname"], :name => "index_userrsches_on_uid_and_sid_and_skname", :unique => true
  add_index "userrsches", ["uid"], :name => "index_userrsches_on_uid", :unique => true

  create_table "users", :force => true do |t|
    t.string   "user"
    t.string   "sid"
    t.integer  "age"
    t.integer  "sex"
    t.string   "title"
    t.integer  "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
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
