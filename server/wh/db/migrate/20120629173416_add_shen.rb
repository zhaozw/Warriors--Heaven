class AddShen < ActiveRecord::Migration
  def self.up
      	add_column "userexts", "shen", :integer, :default=>100
	    add_index "userexts", "shen"
  end

  def self.down
  end
end
