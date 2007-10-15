class AddToAssetChildrenCounter < ActiveRecord::Migration
  def self.up
    add_column :assets, :assets_count, :integer, :default => 0
  end

  def self.down
		remove_column :assets, :assets_count
  end
end
