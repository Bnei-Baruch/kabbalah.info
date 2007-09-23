class ChangeIsHiddenToOnHomepageForPages < ActiveRecord::Migration
  def self.up
  	change_column :pages, :is_published, :boolean, :default => true
  	remove_column :pages, :is_hidden
    add_column :pages, :on_homepage, :boolean, :default => false
    
    #update all pages to be pulished by default
    Asset.find_all_by_resource_type('Page').each{|page| page.resource.update_attributes(:is_published => true, :on_homepage => false)}
  end

  def self.down
    add_column :pages, :is_hidden, :boolean, :default => false
  	remove_column :pages, :on_homepage
  end
end