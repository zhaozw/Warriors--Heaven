class CreateEquipment < ActiveRecord::Migration
  def self.up
    create_table :equipment do |t|
      t.string :eqname
      t.string :eqtype #1: eq 2: fixure 3. pep
      t.string :prop
      t.integer :owner

      t.timestamps
    end
    
    add_index(:equipment, :owner)
  end

  def self.down
    drop_table :equipment
  end
  
=begin
  insert into equipment values(null, 'sword', 1, '{"hp":"100"}',    NULL, NULL, NULL);
  insert into equipment values(null, 'blade', 1, '{"hp":"100"}',    NULL, NULL, NULL);
  insert into equipment values(null, 'armo', 1, '{"hp":"100"}',     NULL, NULL, NULL);
  insert into equipment values(null, 'boots', 1, '{"hp":"100"}',    NULL, NULL, NULL);
  insert into equipment values(null, 'ring', 1, '{"hp":"100"}',     NULL, NULL, NULL);
  insert into equipment values(null, 'necklace', 1, '{"hp":"100"}', NULL, NULL, NULL);
  insert into equipment values(null, 'cap', 1, '{"hp":"100"}',      NULL, NULL, NULL);
  insert into equipment values(null, 'jinchuangyao', 2, '{}',       NULL, NULL, NULL);
=end
end
