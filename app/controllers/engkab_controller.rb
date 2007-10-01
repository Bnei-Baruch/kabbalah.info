class EngkabController < ApplicationController

	# This action will be called for all unrecognized urls
	# Will check for 301/305/404 statuses
	def unrecognized?
		path = @path || build_url(request.env)
		if REDIRECIONS.has_key?(path)
			action = REDIRECIONS[path][:action]
			case action
			when 301 # Permanent redirect
				url_path = REDIRECIONS[path][:url]
				redirect_301(url_path)
				return true
			when 305 # To old site via reverse proxy
				redirect_305(path)
				return true
			when 303 # (See other) Just render this page from ourself w/o any redirect
				real_show(REDIRECIONS[path][:section], REDIRECIONS[path][:id])
				return true
			else
				# Unknown action
				status_404 if (not @path) # i.e. directly from routing and not from show
				return false
			end
		else
			s = @section.to_sym
			i = @id ? @id.to_sym : :nil
			if REVERSE_REDIRECIONS.has_key?(s) && REVERSE_REDIRECIONS[s].has_key?(i)
				redirect_301(REVERSE_REDIRECIONS[s][i])
				return true
			end
		end
		# 404
		status_404 if (not @path) # i.e. directly from routing and not from show
		return false
	end

  # GET /engkab/1
  # GET /engkab/1.xml
  def main_homepage
			@section  = Section.homepage
			@page = Asset.find_by_section_id_and_resource_type(@section.id, 'Homepage')
			@is_homepage = true
			homepage
  end
  
  def show
  	@path = build_url(request.env)
  	@section = params[:section]
  	@id = params[:id]
		return if unrecognized?
		
  	real_show(@section, @id)
	end

protected
  def build_url(env)
		env["SERVER_PROTOCOL"] .split(/\//)[0].downcase + "://" +
		env["HTTP_HOST"] +
		env["REQUEST_URI"]
  end

  def redirect_301(url)
		headers["Status"] = '301 Moved Permanently'
		redirect_to url
  end

  def redirect_302(url)
		headers["Status"] = '302 Moved Temporarily'
		redirect_to url
  end

  def redirect_305(url)
		headers["Status"] = '305 Use Proxy'
		redirect_to url
  end

  def status_404
		render :partial => "engkab/global/status_404", :status => 404, :layout => false
  end

	def real_show(section = nil, id = nil)
    if section == nil || (@section = Section.find_by_permalink(section)) == nil
 			status_404
			return
		end

  	if id
    	@page = Page.find_by_permalink(id, :include => :asset)
    	if @page && (@page.asset.published_page? || logged_in?)
				@page = @page.asset
			else
  			@page ? redirect_302(section_homepage_url(@section)) : status_404
		    return
			end
			@is_homepage = false
		else
  		@page = Asset.find_by_section_id_and_resource_type(@section.id, 'Homepage')
  		unless @page
  			redirect_301(section_homepage_url(@section))
		    return
			end
  		@is_homepage = true
		end

 		if @page == nil
 			status_404
			return
		end

		@layout = @section.layout
		@permitted_assets = @section.permitted_assets
		store_location

		eval "#{@section.hrid}"
	end

  def homepage
		calculate_homepage
		unless @main_homepage
			calculate_main_assets
			calculate_sidebar
		end
		respond
  end
  def video_clips
  	calculate_categories()
		@content_menues = calculate_content_menu(:categories)
		calculate_main_assets
		respond
  end

  def worldwide
		@content_menues = calculate_content_menu(:categories_with_pages)
		if @is_homepage
			@media_category = Asset.media_category(@section)
			@events_category = Asset.events_category(@section)
			@media_pages = Asset.get_pages_by_parent(@media_category)
			@events_pages = Asset.get_pages_by_parent(@events_category)
			@top_video = @page.children[0] && @page.children[0].resource_type.eql?('Video') ? @page.children[0] : nil
		end
		calculate_main_assets
		calculate_sidebar
		respond
  end

  def new_to_kabbalah
		@content_menues = calculate_content_menu(:pages)
		calculate_main_assets
		calculate_sidebar
		calculate_categories( true )
		respond
  end
  def the_zohar
		@content_menues = calculate_content_menu(:pages)
		calculate_main_assets
		calculate_sidebar
		calculate_categories( true )
		respond
  end
  def kabbalah_music
		@content_menues = calculate_content_menu(:pages)
		calculate_main_assets
		calculate_sidebar
		calculate_categories( true )
		respond
  end
  def learning_center
		@content_menues = calculate_content_menu(:pages)
		calculate_main_assets
		calculate_sidebar
		calculate_categories( true )
		respond
  end
	def calculate_sidebar
		@right_box_placeholder = Placeholder.right_box_placeholder
		@right_box_assets = @page.children_by_placeholder(@right_box_placeholder)
	end

	def calculate_content_menu(type)
		case type
		when :categories_with_pages	# like worldwide
			result = []
			@section.assets.select {|s| s.resource_type == 'Category' && s.parent_id == 0}.sort{|a, b| a.position <=> b.position}.each do |cat|
				if cat.children
					result << {
						:list => cat.children.select {|p| p.resource_type == 'Page'},
						:parent_id => cat.id,
						:name => cat.resource.property.title,
						:type => 'page',
						:message => 'New Page'
					}
				end
			end
			result
		when :categories						# like in Video clips
			[
				{
					:list => @section.assets.select {|s| s.resource_type == 'Category' && s.parent_id == @page.parent.parent_id}.sort{|a, b| a.position <=> b.position},
					:parent_id => @page.parent.parent_id,
					:name => 'Categories',
					:type => 'category',
					:message => 'New Category'
				}
			]
		when :pages									# like new to kabbalah
			[
				{
					:list => @section.assets.select {|s| ['Page', 'Category'].include?(s.resource_type) && 
																								s.parent_id == 0
																					}.sort{|a, b| a.position <=> b.position},
					:parent_id => @page.parent_id,
					:name => 'Categories',
					:type => %w{ page category },
					:message => 'New Asset'
				}
			]
		end
		
	end

	def calculate_main_assets
		@main_placeholder = Placeholder.main_placeholder
		@main_assets = @page.children_by_placeholder(@main_placeholder)
	end
	def calculate_homepage
		@left_placeholder = Placeholder.homepage_left
		@left_assets = @page.children_by_placeholder(@left_placeholder)

		@right_placeholder = Placeholder.homepage_right
		@right_assets = @page.children_by_placeholder(@right_placeholder)
	end
	def calculate_categories( simple_mode = false )
		if @page.parent && @page.parent.resource_type == "Category"
    	@category = @page.parent
    	return if simple_mode
    	@category_children = @category.children.select {|i| i.resource_type == "Page"}
    	@categories = Asset.find(:all, :conditions => "parent_id = #{@category.parent_id} and section_id = #{@section.id} and resource_type = 'Category' ", :order => "position ASC")
		else
			@category = @category_children = @categories = nil
		end
	end

	def respond
		action = @is_homepage ? "page/#{@section.hrid}_homepage" : "page/" + @section.hrid
		layout = @is_homepage ? @section.layout  + '_homepage' : @section.layout
    
    respond_to do |format|
      format.html { render :action => action, :layout => layout }
      format.htm  { render :action => action, :layout => layout }
      format.xml  { render :xml => @page.to_xml }
    end
	end
  
end
