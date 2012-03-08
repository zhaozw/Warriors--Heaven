class CreateUserexts < ActiveRecord::Migration
  def self.up
    create_table :userexts do |t|
      t.integer :uid
      t.integer :gold
      t.integer :exp
      t.integer :level
      t.string :prop

      t.timestamps
    end
  end

  def self.down
    drop_table :userexts
  end
end
