class AddPaletteToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :palette, :string
  end

  def self.down
  	remove_column :sections, :palette
  end
end
