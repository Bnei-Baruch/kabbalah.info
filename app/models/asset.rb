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
		 ["Article", "article"],
		 ["Video", "video"],
		 ["Category", "category"]
		].sort
	end

	def self.sections(first = false)

		first ?	
		Section.find(:first).id : 
		Section.find(:all).map {|l| [l.title, l.id]}.sort	
	end
	
	def children_by_placeholder(placeholder)
		Asset.find(:all, :conditions => "parent_id = #{id} AND placeholder_id = #{placeholder.id}")
	end
	
protected
	
	def after_destroy
		self.resource.destroy	
	end
end
