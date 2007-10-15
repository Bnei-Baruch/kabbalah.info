class AddPermittedAssetsToPlaceholder < ActiveRecord::Migration
  def self.up
    add_column :placeholders, :permitted_assets, :string
  end

  def self.down
  	remove_column :placeholders, :permitted_assets
  end
end
