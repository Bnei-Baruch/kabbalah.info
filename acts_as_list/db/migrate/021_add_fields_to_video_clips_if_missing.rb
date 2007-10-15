class AddFieldsToVideoClipsIfMissing < ActiveRecord::Migration
  def self.up
  	add_column :videos, :duration, :string
  	add_column :videos, :size, :string
  end

  def self.down
  	remove_column :videos, :duration
  	remove_column :videos, :size
  end
end
