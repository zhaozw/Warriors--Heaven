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
=begin
    insert into tradables values (null, 'objects/equipments/sword', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/blade', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/ring', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/cap', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/necklace', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/armo', 1, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/jinchuangyao', 2, 10, 100, 0, 0, null, null, null);
=end
  def self.down
    drop_table :tradables
  end
end
