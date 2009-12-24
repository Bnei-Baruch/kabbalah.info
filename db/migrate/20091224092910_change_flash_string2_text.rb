class ChangeFlashString2Text < ActiveRecord::Migration
  def self.up
	change_column :videos, :flash, :text
  end

  def self.down
	change_column :videos, :flash, :string
  end
end
