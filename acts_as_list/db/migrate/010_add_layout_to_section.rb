class AddLayoutToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :layout, :string
  end

  def self.down
  	remove_column :sections, :layout
  end
end
