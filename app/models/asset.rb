class Asset < ActiveRecord::Base
	belongs_to :section
	belongs_to :placeholder
	belongs_to :resource, :polymorphic => true

	acts_as_list  :scope => :parent_id
	acts_as_tree  :order => "position", :counter_cache => true
	
	attr_accessor	:asset_type
	
	def self.asset_types
		[
		 ["Page", "page"],
		 ["Home Page", "homepage"],
		 ["Article", "article"],
		 ["Video", "video"],
		 ["Picture Gallery", "picture_gallery"],
		 ["Picture", "picture"],
		 ["Category", "category"]
		].sort
	end

	def self.sections(first = false)

		first ?	
		Section.find(:first).id : 
		Section.find(:all).map {|l| [l.title, l.id]}.sort	
	end
	
	def children_by_placeholder(placeholder)
		Asset.find(:all, :conditions => "parent_id = #{id} AND placeholder_id = #{placeholder.id}", :order => "position ASC")
	end
	def self.get_pages_by_parent(my_parent)
		if my_parent.is_a?(Asset)
			my_parent.children.select{|x| x.resource_type == 'Page'}
		end
	end
protected
	
	def after_destroy
		self.resource.destroy	
	end
end
