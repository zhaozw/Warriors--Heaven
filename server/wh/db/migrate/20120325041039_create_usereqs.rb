class CreateUsereqs < ActiveRecord::Migration
  def self.up
    create_table :usereqs do |t|
      t.integer :uid
      t.string :sid
      t.integer :eqid
      t.string :eqname
      t.integer :eqslotnum # < 0: woren  =0: not fixed slot >0 fixed slot
      t.string :wearon

      t.timestamps
    end
        add_index(:usereqs, ["uid"], {:unique=>true})
    add_index(:usereqs, ["sid"], {:unique=>true})
  end
  
  def self.down
    drop_table :usereqs
  end
end

=begin                                       
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 1, 'sword', -1, 'hand left', NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 2, 'blade', -1, 'hand right', NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 3, 'armo', 0, NULL, NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 4, 'boots', 1, NULL, NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 5, 'ring', 2, NULL, NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 6, 'necklace', 3, NULL, NULL, NULL);
  insert into usereqs values(null, 1, 'd434740f4ff4a5e758d4f340d7a5f467', 7, 'cap', 4, NULL, NULL, NULL);
  
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 1, 'sword', -1, 'hand left', NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 2, 'blade', -1, 'hand right', NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 3, 'armo', 0, NULL, NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 4, 'boots', 1, NULL, NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 5, 'ring', 2, NULL, NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 6, 'necklace', 3, NULL, NULL, NULL);
  insert into usereqs values(null, 9, '1320346951bf2bc6293fb70cc2a71a05', 7, 'cap', 4, NULL, NULL, NULL);
=end                               