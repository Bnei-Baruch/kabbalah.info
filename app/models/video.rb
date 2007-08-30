class Video < ActiveRecord::Base
	acts_as_asset
	
	validates_format_of :thumbnail_content_type,
											:with => /^image/,
											:message => "-- you can only upload images",
											:if => Proc.new { |u| !u.check_thumbnail }

	
	def check_thumbnail
		@uploaded_thumbnail.blank?
	end

	def uploaded_thumbnail=(file_stream)
		if !file_stream.blank?
			self.thumbnail_name = base_part_of(file_stream.original_filename)
			self.thumbnail_content_type = file_stream.content_type.chomp
			self.thumbnail = file_stream.read
		end
	end

	def base_part_of(file_name)
		File.basename(file_name).gsub(/[^\w._-]/, '' )
	end
	
end
