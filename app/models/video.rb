class Video < ActiveRecord::Base
	acts_as_asset
	
	validates_presence_of :video_link
	
end
