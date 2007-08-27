class AddVideoThumbnailColumns < ActiveRecord::Migration
  def self.up
    add_column :videos, :thumbnail_name, :string
    add_column :videos, :thumbnail_alt, :string
    add_column :videos, :thumbnail_content_type, :string
		change_column :videos, :thumbnail, :binary, :limit => 1.megabyte

  end

  def self.down
  	remove_column :videos, :thumbnail_name
  	remove_column :videos, :thumbnail_alt
  	remove_column :videos, :thumbnail_content_type
  	change_column :videos, :thumbnail, :binary
  end
end
