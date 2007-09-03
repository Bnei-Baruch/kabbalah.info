class EngkabController < ApplicationController
  # GET /engkab/1
  # GET /engkab/1.xml
  def show
    @page = Page.find_by_permalink(params[:id])
 		if @page == nil
			render :file => "public/404.html", :status => 404
			return
		end
		@page_asset = @page.asset
    @page_asset_children = @page_asset.children

    if @page_asset.parent && @page_asset.parent.resource_type == "Category"
    	@category_asset = @page_asset.parent
    	@category_asset_children = @category_asset.children.select {|i| i.resource_type == "Page"}
  	end

    respond_to do |format|
      format.html { render  :action => "page", :layout => "vod" }
      format.xml  { render :xml => @engkab.to_xml }
    end
  end
  
  def method_missing(m)
  	render :text => "ddd#{m.inspect}"
  	return
  end
end
