class Video < ActiveRecord::Base
	belongs_to :category

	validates_format_of :thumbnail_content_type,
											:with => /^image/,
											:message => "-- you can only upload images",
											:if => Proc.new { |u| !u.check_thumbnail }


	def self.category_list
		Category.find(:all).map {|l| [l.title, l.id]}.sort	
	end
	
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
