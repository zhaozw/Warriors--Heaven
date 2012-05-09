class CreateUserquests < ActiveRecord::Migration
  def self.up
    create_table :userquests do |t|
      t.string  :sid
      t.integer :uid
      t.string :name
      t.integer :progress
      t.integer :count
      t.text :prop

      t.timestamps
    end
    add_index(:userquests, ["uid"], {:unique=>true})
  #  add_index(:users, ["sid"], {:unique=>true})
  end

  def self.down
    drop_table :userquests
  end
end
