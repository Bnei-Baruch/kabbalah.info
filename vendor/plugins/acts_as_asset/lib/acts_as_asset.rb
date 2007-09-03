module ActiveRecord; module Acts; end; end 
module ActiveRecord::Acts::ActsAsset
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def acts_as_asset
			has_one :asset, :as => :resource, :dependent => :destroy
			has_one :property, :as => :resource, :dependent => :destroy

	  	before_update do |o|
				o.asset.updated_at = Time.now
				o.asset.save!
			end
		end
	end

	# module InstanceMethods
	#   	def title
	# 		self.property.short_description || ""
	# 	end
	# 
	#   	def short_description
	# 		self.property.short_description || ""
	# 	end
	# 
	#   	def description
	# 		self.property.description || ""
	# 	end
	# 
	#   	def image_file
	# 		self.property.image_storage
	# 	end
	# end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::ActsAsset)