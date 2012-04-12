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

  def self.down
    drop_table :userrsches
  end
end
