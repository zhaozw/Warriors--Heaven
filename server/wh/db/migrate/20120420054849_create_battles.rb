class CreateBattles < ActiveRecord::Migration
  def self.up
    create_table :battles do |t|
      t.string :attacker
      t.string :defenser
      t.integer :ftype       # 0: fight 1: quest fight
      t.integer :status     # 0: stoped
      t.integer  :winner    # 0: attacker 1: defenser
      t.text    :prop

      t.timestamps
    end
  end

  def self.down
    drop_table :battles
  end
end
