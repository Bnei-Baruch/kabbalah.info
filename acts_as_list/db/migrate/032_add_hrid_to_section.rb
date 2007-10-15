class AddHridToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :hrid, :string
  end

  def self.down
  	remove_column :sections, :hrid
  end
end
