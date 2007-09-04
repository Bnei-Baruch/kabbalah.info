class RemoveOldFieldsFromVideos < ActiveRecord::Migration
  def self.up
    remove_column :videos, :title
    remove_column :videos, :short_description
    remove_column :videos, :thumbnail
    remove_column :videos, :thumbnail_name
    remove_column :videos, :thumbnail_alt
    remove_column :videos, :thumbnail_content_type
    remove_column :videos, :description
    remove_column :videos, :is_featured
    remove_column :videos, :in_frontpage
  	
  end

  def self.down
  end
end
