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
			false
		end
	end

	# Find the first page of a section to display
	# It will be or homepage or a first published page
	def section_first_page_url(section)
		homepage = section_homepage_url(section)
		if homepage
			homepage
		else
			assets = Asset.find_all_by_section_id_and_resource_type_and_parent_id(section.id,['Category','Page'],0, :order => 'position ASC')
			
			first_page = assets.detect{|asset| asset.published_page? || asset.category_has_published_page?}
			return nil if (not first_page)
			if first_page.resource_type ==  'Category'
				first_page = first_page.children.first
			end
			site_page_url(first_page)
		end
	end

	def site_page_url(my_object, p_options = nil)
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
		s = section ? section.permalink.to_sym : nil
		i = id ? id.permalink.to_sym : nil
		if REVERSE_REDIRECTIONS.has_key?([s, i])
			REVERSE_REDIRECTIONS[[s, i]]
		else
			args = {:section => section, :id => id}
			args.merge!(p_options) if p_options
			site_page0_url(args)	
		end
	end

end
