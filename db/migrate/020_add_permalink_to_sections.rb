class AddPermalinkToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :permalink, :string
		add_index :sections, :permalink, :unique => true
  end

  def self.down
  	remove_index :sections, :permalink
  	remove_column :sections, :permalink
  end
end
