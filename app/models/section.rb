class Section < ActiveRecord::Base
	has_many :assets

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
	
	def homepage_url
		self.assets.select{|x| x.resource_type == 'Homepage'}
	end
end
