class ImageStorage < ActiveRecord::Base
	has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 1.megabyte,
                 :resize_to => '320x200>',
                 :thumbnails => { :preview => '100x100>' },
                 :processor => "MiniMagick",
                 :path_prefix => "public/files/image_storage"
                 
	validates_as_attachment
end
