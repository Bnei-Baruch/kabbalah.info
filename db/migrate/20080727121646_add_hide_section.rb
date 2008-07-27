class AddHideSection < ActiveRecord::Migration
  def self.up
  	 add_column :sections, :hide_section, :boolean
  end

  def self.down
  	remove_column :sections, :hide_section 
  end
end
