class AddAltToImageStorage < ActiveRecord::Migration
  def self.up
    add_column :image_storages, :alt, :string
  end

  def self.down
  	remove_column :image_storages, :alt
  end
end
