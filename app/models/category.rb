class Category < ActiveRecord::Base
	has_many :videos
	has_one :asset, :as => :resource
end
