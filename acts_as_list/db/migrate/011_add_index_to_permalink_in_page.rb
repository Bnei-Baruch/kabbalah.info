class AddIndexToPermalinkInPage < ActiveRecord::Migration
  def self.up
		add_index :pages, :permalink, :unique => true
  end

  def self.down
  	remove_index :pages, :permalink
  end
end
