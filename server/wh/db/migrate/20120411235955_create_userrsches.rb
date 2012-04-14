class CreateUserrsches < ActiveRecord::Migration
  def self.up
    create_table :userrsches do |t|
      t.integer :uid
      t.string :sid
      t.string :skname
      t.integer :progress

      t.timestamps
    end
  end
       add_index(:users, ["uid", "sid", "skname"], {:unique=>true})
       # create unique index idx1 on userrsches (uid,sid,skname);

  def self.down
    drop_table :userrsches
  end
end
