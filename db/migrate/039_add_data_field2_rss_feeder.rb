class AddDataField2RssFeeder < ActiveRecord::Migration
  def self.up
    add_column :rss_feeders, :data, :text
  end

  def self.down
  	remove_column :rss_feeders, :data
  end
end
