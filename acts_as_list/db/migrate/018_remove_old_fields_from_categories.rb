class RemoveOldFieldsFromCategories < ActiveRecord::Migration
  def self.up
    remove_column :categories, :title
    remove_column :categories, :description
  end

  def self.down
  end
end
