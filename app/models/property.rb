class Property < ActiveRecord::Base
		belongs_to :resource, :polymorphic => true
		has_one :image_storage, :dependent => :destroy
		
		validates_presence_of :title

end
