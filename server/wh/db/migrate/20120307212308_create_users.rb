class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user
    #  t.integer :uid
      t.string :sid
      t.integer :age
      t.integer :race
      t.integer :sex
      t.string :title
  #    t.integer :logo

      t.timestamps
    end
=begin
    insert into users values(NULL, "ju",        "d434740f4ff4a5e758d4f340d7a5f467", 30, 0, 1, "新人",NULL, NULL);
    insert into users values(NULL, "海青天",       "032730df4eb17eaa9b6b83f798b76602", 30, 0, 1, "新人", NULL, NULL);
    insert into users values(NULL, "taiseng",   "9d4a4051baf9d1c4ab7ffa9f6e9ad7b4", 30, 0, 1, "拳术世家",NULL, NULL);
    insert into users values(NULL, "燕北天",       "40d2e044df294a37a604a9458e621018", 30, 0, 1, "剑侠", NULL, NULL);
    insert into users values(NULL, "一灯",        "8800a9ef2d3c91569eff59ed68349e46", 30, 0, 1, "大师", NULL, NULL);
    insert into users values(NULL, "张三疯",       "c630a00633734cf4f5ff4c0de5e6e8b2", 30, 0, 1, "一代宗师", NULL, NULL);
    insert into users values(NULL, "monkey",    "b88f4175ebdee8be89f50d12d7ddb5f3", 30, 0, 1, "新人", NULL, NULL);
    insert into users values(NULL, "king",      "f0a28ae6cc681d3f50ae4f281cab9218", 30, 0, 1, "大侠", NULL, NULL);
    insert into users values(NULL, "queen",     "1320346951bf2bc6293fb70cc2a71a05", 30, 0, 1, "女侠", NULL, NULL);
    insert into users values(NULL, "Linsanity", "dce21c64f8788afce3960cf88734048b", 30, 0, 1, "少侠", NULL, NULL);
    insert into users values(NULL, "Shelton",   "507c5283c26d277878c622da8252ab03", 30, 0, 1, "新人",NULL, NULL);
=end
  end

  def self.down
    drop_table :uesrs
  end
end
