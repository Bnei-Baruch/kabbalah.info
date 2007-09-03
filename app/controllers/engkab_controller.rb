class EngkabController < ApplicationController
  # GET /engkab/1
  # GET /engkab/1.xml
  def show
    @page = Page.find_by_permalink(params[:id])
 		if @page == nil
			render :file => "public/404.html", :status => 404
			return
		end
		@page = @page.asset
		@section = @page.section
    @page_children = @page.children

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
  	render :text => "ddd#{m.inspect}"
  	return
  end
end
