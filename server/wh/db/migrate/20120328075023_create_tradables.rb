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
    insert into tradables values (null, 'objects/equipments/buyi', 1, 10, 100, 0, 0, null, null, null);

    insert into tradables values (null, 'objects/fixtures/jinchuangyao', 2, 10, 100, 0, 0, null, null, null);
 
    insert into tradables values (null, 'objects/equipments/xuezou', 3, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/equipments/tianchanjia', 3, 10, 100, 0, 0, null, null, null);

    insert into tradables values (null, 'objects/special/rename', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/muren', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/goldkeeper', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/addeqslot', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/additemslot', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/meihuazhuang', 4, 10, 100, 0, 0, null, null, null);
    insert into tradables values (null, 'objects/special/shadai', 4, 10, 100, 0, 0, null, null, null);
 


=end
  def self.down
    drop_table :tradables
  end
end
