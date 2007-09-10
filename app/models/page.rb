class Page < ActiveRecord::Base
	acts_as_asset
	
	validates_presence_of :permalink
	validates_uniqueness_of :permalink

# fixing a bug when posting an update without permalink
	def after_validation_on_update
		self.permalink = Page.find_by_id(self.id).permalink if self.permalink.empty?
	end
	
	def to_param
		permalink
	end

end
