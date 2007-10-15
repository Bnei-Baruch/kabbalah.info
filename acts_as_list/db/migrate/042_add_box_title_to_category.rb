class AddBoxTitleToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :box_title, :string
  end

  def self.down
		remove_column :categories, :box_title
  end
end
