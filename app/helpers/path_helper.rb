module PathHelper
	def site_page_url(asset)
		# categories = []
		page = asset.resource
		section = asset.section
		site_page0_url(:section => section, :id => page )
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
	
	def section_homepage_url(section)
		homepage = Asset.find_by_section_id_and_resource_type(section.id,'Homepage')
		if homepage
			site_page0_url(:section => section)
		else
			categories = Asset.find(:all, :conditions => "section_id = #{section.id}  and resource_type = 'Category'", :order => 'position ASC')
			#in case the page is in category - like in vod
			if categories 
				first_category = categories.select{|cat| cat.category_has_published_page?}.first
			else
				first_category = nil
			end
			if first_category
				first_page = first_category.children.select{|asset| asset.is_page? && asset.published_page?}.sort{|a, b| a.position <=> b.position}.first
			#in case the section doesn't have categories - like in new to kabbalah
			else
				first_page = section.assets.select{|page| page.is_page? && page.parent_id == 0 && page.published_page?}.sort{|a, b| a.position <=> b.position}.first
			end 
			site_page0_url(:section => section, :id => first_page.resource)
		end
	end


end
