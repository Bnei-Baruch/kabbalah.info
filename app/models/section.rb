class Section < ActiveRecord::Base
	has_many :assets
	
	def self.get_title_by_id (section_id)
		[find(section_id)].map{|x| x.title}
	end
	
	# def to_param
	# 	self.title
	# end

end
