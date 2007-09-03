class RemoveOldFieldsFromPages < ActiveRecord::Migration
  def self.up
    remove_column :pages, :title
    remove_column :pages, :description
  end

  def self.down
  end
end
