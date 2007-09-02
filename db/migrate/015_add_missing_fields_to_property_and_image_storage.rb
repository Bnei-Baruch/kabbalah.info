class AddMissingFieldsToPropertyAndImageStorage < ActiveRecord::Migration
  def self.up
  	add_column :properties, :created_at, :timestamp
  	add_column :properties, :updated_at, :timestamp
  	add_column :image_storages, :created_at, :timestamp
  	add_column :image_storages, :updated_at, :timestamp
  end

  def self.down
  	remove_column :properties, :created_at
  	remove_column :properties, :updated_at
  	remove_column :image_storages, :created_at
  	remove_column :image_storages, :updated_at
  end
end
