class CreateUserrsches < ActiveRecord::Migration
  def self.up
    create_table :userrsches do |t|
      t.integer :uid
      t.string :sid
      t.string :skname
      t.integer :progress

      t.timestamps
    end
          add_index(:userrsches, ["uid"], {:unique=>true})
    #  add_index(:users, ["sid"], {:unique=>true})
       add_index(:userrsches, ["uid", "sid", "skname"], {:unique=>true})
       # create unique index idx1 on userrsches (uid,sid,skname);
  end


  def self.down
    drop_table :userrsches
  end
end
