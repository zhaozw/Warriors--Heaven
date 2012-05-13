class CreateGlobalquests < ActiveRecord::Migration
  def self.up
    create_table :globalquests do |t|
      t.string :name
      t.integer :stat
      t.text :prop
      t.datetime :finishedat

      t.timestamps
    end
  end

  def self.down
    drop_table :globalquests
  end
end
