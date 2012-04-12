class CreateTradables < ActiveRecord::Migration
  def self.up
    create_table :tradables do |t|
      t.string :name
      t.integer :obtype #1: ep 2: fixure 3. pep
      t.integer :price
      t.integer :number
      t.integer :soldnum
      t.integer :owner
      t.string :ownername

      t.timestamps
    end
  end
ActiveRecord::Base.connection.execute("
    insert into tradables values (null, 'sword', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'blade', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'ring', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'cap', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'necklace', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'armo', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'jinchuangyao', 2, 10, 100, 0, 0, null, null, null);
")
  def self.down
    drop_table :tradables
  end
end
