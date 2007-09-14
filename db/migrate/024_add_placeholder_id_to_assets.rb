class AddPlaceholderIdToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :placeholder_id, :integer
  end

  def self.down
  	remove_column :assets, :placeholder_id
  end
end
