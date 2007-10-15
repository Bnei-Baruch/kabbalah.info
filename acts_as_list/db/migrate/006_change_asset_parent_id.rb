class ChangeAssetParentId < ActiveRecord::Migration
  def self.up
  	change_column :assets, :parent_id, :integer, :default => 0
  end

  def self.down
  	change_column :assets, :parent_id, :integer
  end
end
