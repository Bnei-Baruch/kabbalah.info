class AddPermittedAssetsToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :permitted_assets, :string
  end

  def self.down
  	remove_column :sections, :permitted_assets
  end
end
