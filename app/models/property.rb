class Property < ActiveRecord::Base
		belongs_to :resource, :polymorphic => true
		has_one :image_storage, :dependent => :destroy
		
		validates_presence_of :title

	def title_for_anchor
		#title.gsub(/ /, '-').gsub(/"|'/,'')
		title.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
			'-' + $1.unpack('H2' * $1.size).join('-').upcase
		end.tr(' ', '-').downcase
	end
end
