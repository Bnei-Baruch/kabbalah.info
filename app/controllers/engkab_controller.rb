class EngkabController < ApplicationController
  # GET /engkab/1
  # GET /engkab/1.xml
  def show
    @page = Page.find_by_permalink(params[:id])
    @section = Section.find_by_permalink(params[:section])
 		if @page == nil || @section == nil
			status_404
			return
		end
		@page = @page.asset
    @page_children = @page.children

		permitted = @section.permitted_objects
		@layout = permitted[:layout]
		@assets = permitted[:assets]

		store_location
		
		eval "#{@section.layout}"
	end
  
  def method_missing(m)
		m =~ /status_(\d+)/
		status = $1 || 404
		render :file => "public/#{status}.html", :status => status.to_i
  end
  
protected
  
  def vod
  	calculate_categories()
		respond("page")
  end

  def articles
  	calculate_pages()
  	respond("page")
  end

  def calculate_categories
		if @page.parent && @page.parent.resource_type == "Category"
    	@category = @page.parent
    	@category_children = @category.children.select {|i| i.resource_type == "Page"}
    	# render :text => @category_children.inspect
    	# return
    	@categories = Asset.find(:all, :conditions => "parent_id = #{@category.parent_id} and section_id = #{@section.id} and resource_type = 'Category' ", :order => "position ASC")
  	end
  end

	def calculate_pages
  	@pages = Asset.find(:all, :conditions => "parent_id = #{@page.parent_id} and section_id = #{@section.id} and resource_type = 'Page' ", :order => "position ASC")
	end
	
	def respond(action)
    respond_to do |format|
      format.html { render  :action => action, :layout => @section.layout }
      format.xml  { render :xml => @page.to_xml }
    end
	end
  
end
