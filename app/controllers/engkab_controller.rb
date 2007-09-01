class EngkabController < ApplicationController
  # GET /engkab/1
  # GET /engkab/1.xml
  def show
    @page = Page.find_by_permalink(params[:id])
 		if @page == nil
			render :file => "public/404.html", :status => 404
			return
		end
		@asset = @page.asset
    @assets = @asset.children

    respond_to do |format|
      format.html { render  :action => "page", :layout => "vod" }
      format.xml  { render :xml => @engkab.to_xml }
    end
  end

end
