module PathFunctions
  protected

	def section_homepage_url(section)
		homepage = Asset.find_by_section_id_and_resource_type(section.id,'Homepage')
		if homepage
			if section.eql?(Section.homepage) # Homepage of the site?
				mainpage_url
			else
				site_page_url(section)
			end
		else
			assets = Asset.find_all_by_section_id_and_resource_type_and_parent_id(section.id,['Category','Page'],0, :order => 'position ASC')
			first_page = assets.detect {|asset|asset.category_has_published_page? || asset.published_page?}
			return nil if (not first_page)
			if first_page.resource_type ==  'Category'
				first_page = first_page.children.first
			end
			site_page_url(first_page)
		end
	end

	def site_page_url(my_object)
		# in case that the URL is for the section homepage when there is homepage
		if my_object.is_a?(Section)
			section = my_object
			id = nil
			# regular page URL
		elsif my_object.is_a?(Asset)
			section = my_object.section
			id = my_object.resource
		else
			return nil
		end
		
		s = section.permalink.to_sym
		i = id ? id.permalink.to_sym : nil
		if REVERSE_REDIRECIONS.has_key?(s) && REVERSE_REDIRECIONS[s].has_key?(i)
			REVERSE_REDIRECIONS[s][i]
		else
			site_page0_url(:section => section, :id => id )
		end
	end

end
