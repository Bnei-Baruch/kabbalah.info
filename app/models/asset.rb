class Asset < ActiveRecord::Base
	belongs_to :section
	belongs_to :placeholder
	belongs_to :resource, :polymorphic => true

	acts_as_list  :scope => 'parent_id = assets.parent_id AND section_id = assets.section_id AND placeholder_id = assets.placeholder_id'
	acts_as_tree  :order => "position", :counter_cache => true
	
	attr_accessor	:asset_type
	
	def self.asset_types
		[
		 ["Page", "page"],
		 ["Home Page", "homepage"],
		 ["Article", "article"],
		 ["Video Gallery", "video_gallery"],
		 ["Video", "video"],
		 ["Picture Gallery", "picture_gallery"],
		 ["Picture", "picture"],
		 ["Category", "category"],
		 ["RSS Feeder", "rss_feeder"],
		 ["Section Preview", "section_preview"],
		 ["Custom Preview", "custom_preview"],
		 ["Link", "link"],
		 ["Banner", "banner"]
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
	
	def self.get_pages_by_parent(my_parent, only_published = false)

		if my_parent.is_a?(Asset)
			if only_published
				my_parent.children.select{|x| x.published_page?}
			else
				my_parent.children.select{|x| x.resource_type == 'Page'}
			end
		end
	end
	
	def is_page?
		self.resource_type == 'Page'
	end
	
	def page_has_active_assets?
 		self.resource_type == 'Page' &&
 		self.children.any? do |asset| 
			asset.placeholder.eql?(Placeholder.main_placeholder) && Placeholder.main_placeholder.permitted_assets(self.section).any?{|permitted_asset| permitted_asset == asset.resource_type.downcase}
		end

	end
#checking if the page is published according to the presence of permitted assets on the page
	def published_page?
		self.resource_type == 'Page' && self.resource.is_published &&	self.children && self.page_has_active_assets?
	end
	
#checking that the category has published pages	
	def category_has_published_page?
		self.resource_type == 'Category' && self.children && self.children.any? {|page| page.published_page?}
	end
	
	def self.events_category(section)
		categories = Asset.find_all_by_section_id_and_resource_type(section.id, 'Category')
		categories.select{|x| x.resource.property.title.downcase.include? 'events'}.first
	end
	def self.media_category(section)
		categories = Asset.find_all_by_section_id_and_resource_type(section.id, 'Category')
		categories.select{|x| x.resource.property.title.downcase.include? 'media'}.first
	end
	def self.women_header(section)
		categories = Asset.find_all_by_section_id_and_resource_type(section.id, 'Article')
		categories.select{|x| x.resource.property.title.downcase.include? 'women header do not modify title'}.first
	end
protected
	
	def after_destroy
		self.resource.destroy	
	end
	def has_picture_gallery?
		is_page? && self.children.any? {|c| c.resource_type == "PictureGallery"}
	end
end
