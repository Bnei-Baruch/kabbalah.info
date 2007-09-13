class StylesController < ApplicationController
	layout nil
	
	def show
		@cssfile = params[:id] + ".css"
		@section = Section.find_by_permalink(params[:section_id])
		permitted = @section.permitted_objects
		@layout = permitted[:layout]
		@assets = permitted[:assets]
    respond_to do |format|
    	if @section && File.exists?("#{RAILS_ROOT}/app/views/styles/#{@cssfile}")
    		expires_in 60.minutes
	      format.css { render(:file => "styles/#{@cssfile}", :use_full_path => true, :content_type => "text/css") }
			else
				format.css { render :file => "public/404.html", :status => 404, :content_type => "text/html" }
			end
    end
	end

protected
	
	def method_missing(m)
		render :file => "public/404.html", :status => 404, :content_type => "text/html"
		return
  end

end
