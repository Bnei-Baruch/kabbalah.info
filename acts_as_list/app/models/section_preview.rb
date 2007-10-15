class SectionPreview < ActiveRecord::Base
	belongs_to :section
	acts_as_asset
end
