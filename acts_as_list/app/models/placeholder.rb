class Placeholder < ActiveRecord::Base
	has_many :assets

	validates_presence_of :name
	validates_uniqueness_of :name
	
	# makes an array of permitted assets only in section and placeholder
	def permitted_assets(section = nil)
		if section
			read_attribute("permitted_assets" ).split(' ') & section.permitted_assets 
		else
			read_attribute("permitted_assets" )
		end
	end
	def premited_assets_for_select(section)
		permitted_assets(section).map{|x| [x.camelize, x].sort}
	end	
	#array of placeholders for select dropdown
	def self.placeholders

		Placeholder.find(:all).map {|l| [l.name, l.id]}.sort	
	end
	
	def self.main_placeholder
		find(1)
	end

	def self.right_box_placeholder
		find(2)
	end
	
	def self.homepage_left
		find(3)
	end
	
	def self.homepage_right
		find(4)
	end
	
end
