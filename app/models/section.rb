class Section < ActiveRecord::Base
	has_many :assets
	acts_as_list

	validates_presence_of :permalink
	validates_uniqueness_of :permalink
	
	def self.get_title_by_id (section_id)
		[find(section_id)].map{|x| x.title}
	end
	
	def to_param
		permalink
	end

	def permitted_assets
		read_attribute("permitted_assets" ) ? read_attribute("permitted_assets" ).split(' ') : ""
	end
	
	def self.environments
		Section.find(:all, :order => 'position ASC').select{|section| section.is_environment? && section.active_environment?}
	end
	
	def is_environment?
		!self.layout.blank?
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
	def homepage_preview(number = 3)
		latest_pages = Asset.find_all_by_section_id_and_resource_type_and_on_homepage(self.id, 'Page', false, :order => 'created_at DESC', :limit => number)
		manual_selected_pages = Asset.find_all_by_section_id_and_resource_type_and_on_homepage(self.id, 'Page', true, :order => 'created_at DESC', :limit => number)
		
		#Calculate result
		result = []
		left_number = number
		if manual_selected_pages
			result = manual_selected_pages
			left_number -= manual_selected_pages.size
		end
		if latest_pages
			if left_number > 0 
				left_number.times do |i|
					result << latest_pages[i]
				end
			end
		end			
		return result
	end
end
