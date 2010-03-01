class AddTarget2CustomPreview < ActiveRecord::Migration
  def self.up
		add_column :custom_previews, :is_internal, :boolean
  end

  def self.down
		remove_column :custom_previews, :is_internal
  end
end
