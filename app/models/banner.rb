class Banner < ActiveRecord::Base
	acts_as_asset
	has_and_belongs_to_many :sections
end
