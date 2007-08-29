class Asset < ActiveRecord::Base
	belongs_to :section
	belongs_to :resource, :polymorphic => true

	acts_as_list  :scope => :parent_id
	acts_as_tree  :order => "position"
	
	attr_accessor	:asset_type
	
	def self.asset_types
		[
		 ["Article", "article"],
		 ["Video", "video"],
		 ["Image", "image"],
		 ["Category", "category"]
		].sort
	end

	def self.sections(first = false)
		first ?	
		Section.find(:first).id : 
		Section.find(:all).map {|l| [l.title, l.id]}.sort	
	end
end
