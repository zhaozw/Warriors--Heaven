class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user
    #  t.integer :uid
      t.string :sid
      t.integer :age
      #t.integer :race
      t.integer :sex
      t.string :title
      t.integer :profile

      t.timestamps
    end
        add_index(:users, ["user"], {:unique=>true})
        add_index(:users, ["sid"], {:unique=>true})
=begin
    insert into users values(NULL, "ju",        "d434740f4ff4a5e758d4f340d7a5f467", 30, 1, "新人",     0, NULL, NULL);
    insert into users values(NULL, "海青天",       "032730df4eb17eaa9b6b83f798b76602", 30, 1, "新人",     1, NULL, NULL);
    insert into users values(NULL, "taiseng",   "9d4a4051baf9d1c4ab7ffa9f6e9ad7b4", 30, 1, "拳术世家",   2, NULL, NULL);
    insert into users values(NULL, "燕北天",       "40d2e044df294a37a604a9458e621018", 30, 1, "剑侠",     3, NULL, NULL);
    insert into users values(NULL, "一灯",        "8800a9ef2d3c91569eff59ed68349e46", 30, 1, "大师",     4, NULL, NULL);
    insert into users values(NULL, "张三疯",       "c630a00633734cf4f5ff4c0de5e6e8b2", 30, 1, "一代宗师",   5, NULL, NULL);
    insert into users values(NULL, "monkey",    "b88f4175ebdee8be89f50d12d7ddb5f3", 30, 1, "新人",     1, NULL, NULL);
    insert into users values(NULL, "king",      "f0a28ae6cc681d3f50ae4f281cab9218", 30, 1, "大侠",     0, NULL, NULL);
    insert into users values(NULL, "queen",     "1320346951bf2bc6293fb70cc2a71a05", 30, 0, "女侠",     0, NULL, NULL);
    insert into users values(NULL, "Linsanity", "dce21c64f8788afce3960cf88734048b", 30, 1, "少侠",     1, NULL, NULL);
    insert into users values(NULL, "Shelton",   "507c5283c26d277878c622da8252ab03", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(15,   "Spring",    "512298b206ac82df11e370f4021736d0", 14, 1, "新人",     2, NULL, NULL);
    insert into users values(24, "真还赚",       "974c388ca997e6c2476d2b31d9a7eb8b", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(25, "终南山旅游事业管理局","a705fc0c1e7436c11fd5ddf78d7cb749", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(26, "奥巴马",       "468fbf1a7d1ab357449952bf0905bc7b", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(27, "sunbin",    "8d5ccab3fb48a7129fc6054ecaea49d7", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(28, "Tony",      "ec576b4c8a06ab48c34862b326a9a1c9", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(29, "gaga",      "e9aa6f125a7eba6095c8c8cdb9edba9b", 30, 0, "新人",     2, NULL, NULL);
    insert into users values(30, "Panny",     "39114fbad1760548b4ebf190d8fddcd9", 30, 1, "新人",     2, NULL, NULL);
    insert into users values(31, "新佑卫门",      "cd4a83c68453e5b86121e5bfbf5dee21", 30, 0, "新人",     2, NULL, NULL);
    insert into users values(32, "川上奈美子",      "0b78afa2308695a384518c98e2764130", 30, 0, "新人",     2, NULL, NULL);


=end
  end

  def self.down
    drop_table :uesrs
  end
end
