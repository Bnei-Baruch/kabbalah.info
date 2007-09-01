class Page < ActiveRecord::Base
	acts_as_asset
	
	validates_presence_of :title, :permalink
	validates_uniqueness_of :title, :permalink
	
	def to_param
		permalink
	end

end
