class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :name
      t.string :dname #display name
      
      t.timestamps
    end
  end
=begin
    insert into skills values (null, 'unarmed', 'unarmed', null, null);
    insert into skills values (null, 'dodge', 'dodge', null, null);
    insert into skills values (null, 'parry', 'parry', null, null);

=end
  def self.down
    drop_table :skills
  end
end
