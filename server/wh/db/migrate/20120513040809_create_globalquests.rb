class CreateGlobalquests < ActiveRecord::Migration
  def self.up
    create_table :globalquests do |t|
      t.string :name
      t.integer :stat # 0: created and waiting 1: fighting or in progress 2: finished
      t.text :prop
      t.datetime :finishedat

      t.timestamps
    end
  end

  def self.down
    drop_table :globalquests
  end
end
