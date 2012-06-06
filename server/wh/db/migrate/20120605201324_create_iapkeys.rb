class CreateIapkeys < ActiveRecord::Migration
  def self.up
    create_table :iapkeys do |t|
      t.integer :uid
      t.string :sid
      t.string :key
      t.string :tid

      t.timestamps
    end
              add_index(:iapkeys, ["tid"], {:unique=>true})
  end

  def self.down
    drop_table :iapkeys
  end
end
