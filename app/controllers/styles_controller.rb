class StylesController < ApplicationController
	layout nil

	PALETTE =
	{
		:blue => {
			:middle_hd_bg => "#4E4E4E",
			:middle_hd_fg => "#D7DBDE",
			:bottom_line => "#73787b",
			:h2_font_size => "100%",
			:category_active => "#afdedf",
			:general_border => "#a5a7a9",
			:related_bg => "#f7f7f8",
			:category_fg => "#77797c",
			:category_bg => "#eff8f8",
			:category_hd_bg => "#909295",
			:category_hd_fg => "#cecfd1",
			:services_hd_bg => "#b5d2e2",
			:services_hd_fg => "#0698bc",
			:services_bottom_line => "#8ebdd5",
		},
		:green => {
			:middle_hd_bg => "#485458",
			:middle_hd_fg => "#cecfd1",
			:bottom_line => "#73787b",
			:h2_font_size => "85%",
			:category_active => "#bfdb89",
			:general_border => "#a5a7a9",
			:related_bg => "#f7f7f8",
			:category_fg => "#77797c",
			:category_bg => "#f1f7e7",
			:category_hd_bg => "#909295",
			:category_hd_fg => "#cecfd1",
			:services_hd_bg => "#b5d2e2",
			:services_hd_fg => "#0698bc",
			:services_bottom_line => "#8ebdd5",
		},
		:orange => {
			:middle_hd_bg => "#4E4E4E",
			:middle_hd_fg => "#D7DBDE",
			:bottom_line => "#73787b",
			:h2_font_size => "100%",
			:category_active => "#FAB597",
			:general_border => "#a5a7a9",
			:related_bg => "#f7f7f8",
			:category_fg => "#77797c",
			:category_bg => "#FFEFE9",
			:category_hd_bg => "#909295",
			:category_hd_fg => "#cecfd1",
			:services_hd_bg => "#b5d2e2",
			:services_hd_fg => "#0698bc",
			:services_bottom_line => "#8ebdd5",
		},
	}

	def show
		cssfile = params[:id] + ".css"
		section = Section.find_by_permalink(params[:section_id])
		@layout = section.layout
		@palette_name = section.palette
		@palette = PALETTE[section.palette.to_sym]
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
