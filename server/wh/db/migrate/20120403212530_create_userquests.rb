class CreateUserquests < ActiveRecord::Migration
  def self.up
    create_table :userquests do |t|
      t.string  :sid
      t.integer :uid
      t.string :name
      t.integer :progress

      t.timestamps
    end
  end

  def self.down
    drop_table :userquests
  end
end
