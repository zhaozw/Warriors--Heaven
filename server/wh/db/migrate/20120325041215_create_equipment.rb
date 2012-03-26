class CreateEquipment < ActiveRecord::Migration
  def self.up
    create_table :equipment do |t|
      t.string :eqname
      t.string :prop

      t.timestamps
    end
  end

  def self.down
    drop_table :equipment
  end
  
=begin
  insert into equipment values(null, 'sword', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'blade', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'armo', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'boots', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'ring', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'necklace', '{"hp":"100"}', NULL, NULL);
  insert into equipment values(null, 'cap', '{"hp":"100"}', NULL, NULL);
=end
end
