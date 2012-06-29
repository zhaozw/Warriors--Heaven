class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
        t.integer :uid
      t.integer :c0         # yunbiao count
      t.integer :c1
      t.integer :c2
      t.integer :c3
      t.integer :c4
      t.integer :c5
      t.integer :c6
      t.integer :c7
      t.integer :c8
      t.integer :c9

      t.timestamps
    end
    add_index(:ranks, ["uid"], {:unique=>true})
    add_index(:ranks, ["c0"])
    add_index(:ranks, ["c1"])
    add_index(:ranks, ["c2"])
    add_index(:ranks, ["c3"])
    add_index(:ranks, ["c4"])
    add_index(:ranks, ["c5"])
    add_index(:ranks, ["c6"])
    add_index(:ranks, ["c7"])
    add_index(:ranks, ["c8"])
    add_index(:ranks, ["c9"])
    
  end

  def self.down
    drop_table :ranks
  end
end
