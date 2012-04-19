class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer     :owner
      t.string      :code
      t.integer     :power  # 战斗力评估
      t.text        :prop

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
