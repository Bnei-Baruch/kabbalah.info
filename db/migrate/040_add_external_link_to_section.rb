class AddExternalLinkToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :external_link, :string
  end

  def self.down
		remove_column :sections, :external_link
  end
end
