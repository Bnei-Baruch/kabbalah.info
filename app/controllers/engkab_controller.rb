class EngkabController < ApplicationController
  # GET /engkab/1
  # GET /engkab/1.xml
  def show
  		# render :text => params.inspect
  		# return
    @section = Section.find_by_permalink(params[:section])

 		if @section == nil
			status_404
			return
		end

  	if params[:id]
    	@page = Page.find_by_permalink(params[:id])
			if @page
				@page = @page.asset
			end
			@is_homepage = false
		else
  		@page = Asset.find_by_section_id_and_resource_type(@section.id, 'Homepage')
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
  
  def method_missing(m)
		render :text => "#{m}"
		return
		m =~ /status_(\d+)/
		status = $1 || 404
		render :file => "public/#{status}.html", :status => status.to_i
  end
  
protected
  
  def video_clips
  	calculate_categories()
		@content_menues = calculate_content_menu(:categories)
		calculate_main_assets
		respond
  end

  def worldwide
		@content_menues = calculate_content_menu(:categories_with_pages)
		respond
  end

  def new_to_kabbalah
		@content_menues = calculate_content_menu(:pages)
		calculate_main_assets
		calculate_sidebar
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
			@section.assets.select {|s| s.resource_type == 'Category' && s.parent_id == @page.parent.parent_id}.sort{|a, b| a.position <=> b.position}.each do |cat|
				result << {
					:list => @section.assets.select {|s| s.resource_type == 'Page' && s.parent_id == @cat.parent_id}.sort{|a, b| a.position <=> b.position},
					:parent_id => @cat.id,
					:name => @cat.resource.property.title,
					:type => 'Page',
					:message => 'New page'
				}
			end
			result
		when :categories						# like in Video clips
			[
				{
					:list => @section.assets.select {|s| s.resource_type == 'Category' && s.parent_id == @page.parent.parent_id}.sort{|a, b| a.position <=> b.position},
					:parent_id => @page.parent.parent_id,
					:name => 'Categories',
					:type => 'Category',
					:message => 'New category'
				}
			]
		when :pages									# like new to kabbalah
			[
				{
					:list => @section.assets.select {|s| s.resource_type == 'Page' && s.parent_id == @page.parent_id}.sort{|a, b| a.position <=> b.position},
					:parent_id => @page.parent_id,
					:name => 'Categories',
					:type => 'page',
					:message => 'New page'
				}
			]
		end
		
	end

	def calculate_main_assets
		@main_placeholder = Placeholder.main_placeholder
		@main_assets = @page.children_by_placeholder(@main_placeholder)
	end

  def calculate_categories
		if @page.parent && @page.parent.resource_type == "Category"
    	@category = @page.parent
    	@category_children = @category.children.select {|i| i.resource_type == "Page"}
    	@categories = Asset.find(:all, :conditions => "parent_id = #{@category.parent_id} and section_id = #{@section.id} and resource_type = 'Category' ", :order => "position ASC")
  	else
  		@category = @category_children = @categories = nil
  	end
  end

	def calculate_pages
  	@pages = Asset.find(:all, :conditions => "parent_id = #{@page.parent_id} and section_id = #{@section.id} and resource_type = 'Page' ", :order => "position ASC")
	end
	
	def respond
		action = @is_homepage ? "page/#{@section.hrid}_homepage" : "page/" + @section.hrid
    respond_to do |format|
      format.html { render  :action => action, :layout => @section.layout }
      format.xml  { render :xml => @page.to_xml }
    end
	end
  
end
