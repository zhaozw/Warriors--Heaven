class CreateUserskills < ActiveRecord::Migration
  def self.up
    create_table :userskills do |t|
      t.integer :uid
      t.string  :sid
      t.integer :skid
      t.string  :skname
      t.string  :skdname
      t.integer :level
      t.integer :tp
      t.integer :enabled

      t.timestamps
    end
    # add_index(:userskills, ["uid"], {:unique=>true})
#    add_index(:users, ["sid"], {:unique=>true})
    add_index(:userskills, ["uid", "skname"], {:unique=>true})
  end
=begin
    insert into userskills values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 1, 'unarmed',  'unarmed',   0, 0, 1, null, null);
    insert into userskills values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 2, 'dodge',    'dodge',     0, 0, 1, null, null);
    insert into userskills values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 3, 'parry',    'parry',     0, 0, 1, null, null);
                                                                                                                 
    insert into userskills values(null, 2, '032730df4eb17eaa9b6b83f798b76602', 1, 'unarmed',  'unarmed',   0, 0, 1, null, null);
    insert into userskills values(null, 2, '032730df4eb17eaa9b6b83f798b76602', 2, 'dodge',    'dodge',     0, 0, 1, null, null);
    insert into userskills values(null, 2, '032730df4eb17eaa9b6b83f798b76602', 3, 'parry',    'parry',     0, 0, 1, null, null);    
                                                                                                                 
    insert into userskills values(null, 3, '9d4a4051baf9d1c4ab7ffa9f6e9ad7b4', 1, 'unarmed',  'unarmed',  50, 0, 1, null, null);
    insert into userskills values(null, 3, '9d4a4051baf9d1c4ab7ffa9f6e9ad7b4', 2, 'dodge',    'dodge',    30, 0, 1, null, null);
    insert into userskills values(null, 3, '9d4a4051baf9d1c4ab7ffa9f6e9ad7b4', 3, 'parry',    'parry',    50, 0, 1, null, null);    
                                                                                                                 
    insert into userskills values(null, 6, 'c630a00633734cf4f5ff4c0de5e6e8b2', 1, 'unarmed',  'unarmed', 200, 0, 1, null, null);
    insert into userskills values(null, 6, 'c630a00633734cf4f5ff4c0de5e6e8b2', 2, 'dodge',    'dodge',   200, 0, 1, null, null);
    insert into userskills values(null, 6, 'c630a00633734cf4f5ff4c0de5e6e8b2', 3, 'parry',    'parry',   200, 0, 1, null, null);
                                                                                              
    insert into userskills values(null, 4, '40d2e044df294a37a604a9458e621018', 1, 'unarmed',  'unarmed',  100, 0, 1, null, null);
    insert into userskills values(null, 4, '40d2e044df294a37a604a9458e621018', 2, 'dodge',    'dodge',    100, 0, 1, null, null);
    insert into userskills values(null, 4, '40d2e044df294a37a604a9458e621018', 3, 'parry',    'parry',    100, 0, 1, null, null);     
                                                                                              
    insert into userskills values(null, 7, 'b88f4175ebdee8be89f50d12d7ddb5f3', 1, 'unarmed',   'unarmed', 10, 0, 1, null, null);
    insert into userskills values(null, 7, 'b88f4175ebdee8be89f50d12d7ddb5f3', 2, 'dodge',     'dodge',   50, 0, 1, null, null);
    insert into userskills values(null, 7, 'b88f4175ebdee8be89f50d12d7ddb5f3', 3, 'parry',     'parry',   10, 0, 1, null, null);  
                                                                                              
    insert into userskills values(null, 11, '507c5283c26d277878c622da8252ab03', 1, 'unarmed', 'unarmed',  0, 0, 1, null, null);
    insert into userskills values(null, 11, '507c5283c26d277878c622da8252ab03', 2, 'dodge',   'dodge',    0, 0, 1, null, null);
    insert into userskills values(null, 11, '507c5283c26d277878c622da8252ab03', 3, 'parry',   'parry',    0, 0, 1, null, null);  
                                                                                              
    insert into userskills values(null, 5, '8800a9ef2d3c91569eff59ed68349e46', 1, 'unarmed', 'unarmed', 50, 0, 1, null, null);
    insert into userskills values(null, 5, '8800a9ef2d3c91569eff59ed68349e46', 2, 'dodge',   'dodge',   50, 0, 1, null, null);
    insert into userskills values(null, 5, '8800a9ef2d3c91569eff59ed68349e46', 3, 'parry',   'parry',   50, 0, 1, null, null);  
=end
  def self.down
    drop_table :userskills
  end
end
