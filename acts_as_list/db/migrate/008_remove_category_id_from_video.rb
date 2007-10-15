class RemoveCategoryIdFromVideo < ActiveRecord::Migration
  def self.up
  	remove_column :videos, :category_id
  end

  def self.down
  end
end
