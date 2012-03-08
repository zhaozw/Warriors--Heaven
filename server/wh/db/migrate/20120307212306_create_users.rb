class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user
      t.integer :uid
      t.string :sid
      t.integer :age
      t.integer :race
      t.integer :sex

      t.timestamps
    end
    #insert into users values(NULL, "ju", 0, "d434740f4ff4a5e758d4f340d7a5f467", 30, 0, 1, NULL, NULL);
  end

  def self.down
    drop_table :uesrs
  end
end
