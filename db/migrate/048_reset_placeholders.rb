class ResetPlaceholders < ActiveRecord::Migration
  def self.up
    ['Page', 'Link', 'Category'].each { |type|
      Asset.find_all_by_resource_type(type).each { |asset|
        asset.placeholder_id = 0
        asset.save
      }
    }

    change_column :assets, :placeholder_id, :integer, :default => 0
  end

  def self.down
  end
end
