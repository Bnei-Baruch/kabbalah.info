class Section < ActiveRecord::Base
	has_many :assets
	has_many :section_previews
	has_and_belongs_to_many :banners

	acts_as_list

	validates_presence_of :permalink
	validates_uniqueness_of :permalink
	
	def self.get_title_by_id (section_id)
		[find(section_id)].map{|x| x.title}
	end
	
	def to_param
		permalink
	end
	
	def self.homepage
		Section.find_by_hrid('homepage')
	end

	def self.worldwide
		Section.find_by_hrid('worldwide')
	end

	def permitted_assets
		read_attribute("permitted_assets" ) ? read_attribute("permitted_assets" ).split(' ') : ""
	end
	
	# List of sections. Option to show external links. Option to exclude homepage section.
	def self.environments(show_homepage = true, show_links = false )
		environments = Section.find(:all, :order => 'position ASC')
		if show_links
			environments = environments.select{|section| section.is_environment? && section.active_environment? || section.is_external_link?}
		else
			environments = environments.select{|section| section.is_environment? && section.active_environment?}
		end
		if (not show_homepage)
			environments = environments.reject{|section| section.eql?(Section.homepage)}
		end
		return environments
	end
	
	def is_environment?
	!self.layout.blank? && self.external_link.blank?
	end

	def is_external_link?
	!self.external_link.blank?
	end

	def active_environment?
		if has_homepage?
			true
		else
			pages = Asset.find(:all, :conditions => "section_id = #{self.id} and resource_type = 'Page'")
			pages && pages.any?{|page| page.published_page?}
		end
	end

	def has_homepage?
		Asset.find(:all, :conditions => "section_id = #{self.id} and resource_type = 'Homepage'") != []
	end

	# Preview of the section's most recent pages or custom selected by editor
	# for the homepage
	def homepage_preview(length)
		return nil unless self.active_environment?
		#initialize default length
		length = 3 unless length
		#if worldwide section show only event (prevents showing media pages!!!)
		self.eql?(Section.worldwide) ? container = Asset.events_category(self) : container = nil
		if container
			pages = Asset.find_all_by_section_id_and_parent_id_and_resource_type(self.id, container.id, 'Page', :order => 'created_at DESC')
		else
			pages = Asset.find_all_by_section_id_and_resource_type(self.id, 'Page', :order => 'created_at DESC')
		end
		pages = pages.select{|page| page.published_page? }
		#collection of the pages that were selected to put on homepage limited by 'length'
		manual_selected_pages = pages.select{|page| page.resource.on_homepage }[0, length]
		#collection of recent created pages limited by 'number'
		latest_pages = pages.reject{|page| page.resource.on_homepage }[0, length]
		
		result = ((manual_selected_pages + latest_pages).compact.uniq)[0, length]
		result && result.size > 0 ? result : nil

	end
end
