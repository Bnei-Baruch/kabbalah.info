module PathHelper
	def section_url(asset)
		# categories = []
		page = asset.resource
		section = asset.section
		section0_url(:section => section, :id => page )
		# parent = asset.parent
		# while parent && parent.resource_type == "Category"
		# 	categories << parent.resource
		# 	parent = parent.parent
		# end
		# case categories.size
		# 	when 0
		# 		section0_url(:section => section, :id => page )
		# 	when 1
		# 		section1_url(:section => section, :category0 => categories[0], :id => page )
		# 	when 2
		# 		section1_url(:section => section, :category0 => categories[0], :category1 => categories[1], :id => page )
		# end
	end

end
