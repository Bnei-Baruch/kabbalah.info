require 'config'

class StylesController < ApplicationController

	layout nil

#	PALETTE = YAML.load(File.open("#{RAILS_ROOT}/config/palette.yml"))

	def show
		cssfile = params[:id] + ".css"
		section_id = param_by_pattern('section_id')
		section = Section.find_by_permalink(section_id)
		@layout = section.layout
		@palette_name = section.palette
		@palette = Config::PALETTE[section.palette.to_sym] || Config::PALETTE[:blue]
		@permitted_assets = section.permitted_assets
    respond_to do |format|
    	if section && File.exists?("#{RAILS_ROOT}/app/views/styles/#{cssfile}")
    		expires_in 360.minutes
	      format.css { render(:file => "styles/#{cssfile}", :use_full_path => true, :content_type => "text/css") }
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
