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

	store_location

	if @page.parent && @page.parent.resource_type == "Category"
    	@category = @page.parent
    	@category_children = @category.children.select {|i| i.resource_type == "Page"}
    	# render :text => @category_children.inspect
    	# return
    	@categories = Asset.find(:all, :conditions => "parent_id = #{@category.parent_id}", :order => "position ASC")
  	end

    respond_to do |format|
      format.html { render  :action => "page", :layout => "vod" }
      format.xml  { render :xml => @page.to_xml }
    end
  end
  
  def method_missing(m)
		m =~ /status_(\d+)/
		status = $1 || 404
		render :file => "public/#{status}.html", :status => status.to_i
  end
  
end
