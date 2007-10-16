class AddFlashToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :flash, :string
  end

  def self.down
  	remove_column :videos, :flash
  end
end
