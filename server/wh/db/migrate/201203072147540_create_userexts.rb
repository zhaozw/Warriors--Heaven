class CreateUserexts < ActiveRecord::Migration
  def self.up
    create_table :userexts do |t|
      t.integer :uid
      t.string  :name
      t.integer :gold
      t.integer :exp
      t.integer :level
      t.string  :lastact    # last action
      t.text    :prop
      t.string  :sid
      t.integer :hp
      t.integer :maxhp
      t.integer :stam    #stamina
      t.integer :maxst   #max stamina
      t.integer :str     #strength 
      t.integer :dext    #Dexterity
      t.integer :luck    #0~100
      t.integer :fame
      t.string  :race
      t.integer :pot     # potential
      t.integer :it      # intellegence
      t.integer :jingli  # spirit energe
      t.integer :max_jl
      t.integer :zhanyi, :default=>100 # will to fight

      t.timestamps
    end
  end
=begin
insert into userexts values(null, 1, "ju",          100, 0,  0, '', '{"max_eq":"5", "max_item":10, "badges":[{"name":"badge1", "dname":"一级铁十字勋章", "image":"/game/badges/badge1.png"}]}', 'd434740f4ff4a5e758d4f340d7a5f467', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 2, "海青天",         100, 0,  0, '', '{}', '032730df4eb17eaa9b6b83f798b76602', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 3, "taiseng",     100, 0, 10, '', '{}', '9d4a4051baf9d1c4ab7ffa9f6e9ad7b4', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 4, "燕北天",         100, 0, 20, '', '{}', '40d2e044df294a37a604a9458e621018', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 5, "一灯",          100, 0, 20, '', '{}', '8800a9ef2d3c91569eff59ed68349e46', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 6, "张三疯",         100, 0, 30, '', '{}', 'c630a00633734cf4f5ff4c0de5e6e8b2', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 7, "monkey",      100, 0, 10, '', '{}', 'b88f4175ebdee8be89f50d12d7ddb5f3', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 8, "king",        100, 0, 10, '', '{}', 'f0a28ae6cc681d3f50ae4f281cab9218', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 9, "queen",       100, 0, 10, '', '{"max_eq":"5", "max_item":10, "badges":[{"name":"badge1", "dname":"一级铁十字勋章", "image":"/game/badges100, /badge1.png"}]}', '1320346951bf2bc6293fb70cc2a71a05', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 10,"Linsanity",   100, 0, 10, '', '{}', 'dce21c64f8788afce3960cf88734048b', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
insert into userexts values(null, 11,"Shelton",     100, 0,  0, '', '{}', '507c5283c26d277878c622da8252ab03', 100, 100, 100, 100, 20, 20, 50, 0, '', 10, 20, 100, 100, 100, null, null);
#update userexts set prop='{"hand_weapon":"sword"}'  where uid=4;
=end                                
  def self.down
    drop_table :userexts
  end
end
