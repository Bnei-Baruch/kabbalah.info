class StylesController < ApplicationController
	layout nil

	PALETTE =
	{
		:strawberry => {
			# Background of header of a middle (wide) part
			:middle_hd_bg => "#4E4E4E",						# Background
			:middle_hd_fg => "#D7DBDE",						# Foreground
			:bottom_line => "#f5ee4f",						# Bottom line (1px)
			:wide_line => "#ff7152",							# Wide line under header
			:h2_font_size => "100%",							# Size of font
			# Current (active) category background
			# Thick line beneath header
			# Default color for right boxes
			:category_active => "#ffab90",
			# Border around boxes
			:general_border => "#a5a7a9",
			# Background of related items & TOC
			:related_bg => "white",
			# Categories/pages list
			:category_fg => "#77797c",		# Foreground
			:category_bg => "#fff2ec",		# Background
			:category_hd_bg => "#909295",	# Background of header
			:category_hd_fg => "#cecfd1",	# Foreground of header
			# Services
			:services_hd_bg => "#b5d2e2",	# Background of header
			:services_hd_fg => "#0698bc",	# Foreground of header
			:services_bottom_line => "#8ebdd5",	# Bottom line (2px) of header
		},
		:yellow => {
			# Background of header of a middle (wide) part
			:middle_hd_bg => "#4E4E4E",						# Background
			:middle_hd_fg => "#D7DBDE",						# Foreground
			:bottom_line => "#f5ee4f",						# Bottom line (1px)
			:wide_line => "#f4ed4e",							# Wide line under header
			:h2_font_size => "100%",							# Size of font
			# Current (active) category background
			# Thick line beneath header
			# Default color for right boxes
			:category_active => "#f9f5b0",
			# Border around boxes
			:general_border => "#a5a7a9",
			# Background of related items & TOC
			:related_bg => "white",
			# Categories/pages list
			:category_fg => "#77797c",		# Foreground
			:category_bg => "#fbfded",		# Background
			:category_hd_bg => "#909295",	# Background of header
			:category_hd_fg => "#cecfd1",	# Foreground of header
			# Services
			:services_hd_bg => "#b5d2e2",	# Background of header
			:services_hd_fg => "#0698bc",	# Foreground of header
			:services_bottom_line => "#8ebdd5",	# Bottom line (2px) of header
		},
		:olive => {
			# Background of header of a middle (wide) part
			:middle_hd_bg => "#4E4E4E",						# Background
			:middle_hd_fg => "#D7DBDE",						# Foreground
			:bottom_line => "#73787b",						# Bottom line (1px)
			:wide_line => "#bab778",							# Wide line under header
			:h2_font_size => "100%",							# Size of font
			# Current (active) category background
			# Thick line beneath header
			# Default color for right boxes
			:category_active => "#bbb879",
			# Border around boxes
			:general_border => "#a5a7a9",
			# Background of related items & TOC
			:related_bg => "white",
			# Categories/pages list
			:category_fg => "#77797c",		# Foreground
			:category_bg => "#edefdf",		# Background
			:category_hd_bg => "#909295",	# Background of header
			:category_hd_fg => "#cecfd1",	# Foreground of header
			# Services
			:services_hd_bg => "#b5d2e2",	# Background of header
			:services_hd_fg => "#0698bc",	# Foreground of header
			:services_bottom_line => "#8ebdd5",	# Bottom line (2px) of header
		},
		:blue => {
			# Background of header of a middle (wide) part
			:middle_hd_bg => "#4E4E4E",						# Background
			:middle_hd_fg => "#D7DBDE",						# Foreground
			:bottom_line => "#73787b",						# Bottom line (1px)
			:wide_line => "#afdedf",							# Wide line under header
			:h2_font_size => "100%",							# Size of font
			# Current (active) category background
			:category_active => "#afdedf",
			# Border around boxes
			:general_border => "#a5a7a9",
			# Background of related items & TOC
			:related_bg => "#f7f7f8",
			# Categories/pages list
			:category_fg => "#77797c",		# Foreground
			:category_bg => "#eff8f8",		# Background
			:category_hd_bg => "#909295",	# Background of header
			:category_hd_fg => "#cecfd1",	# Foreground of header
			# Services
			:services_hd_bg => "#b5d2e2",	# Background of header
			:services_hd_fg => "#0698bc",	# Foreground of header
			:services_bottom_line => "#8ebdd5",	# Bottom line (2px) of header
		},
		:green => {
			:middle_hd_bg => "#485458",
			:middle_hd_fg => "#cecfd1",
			:bottom_line => "#73787b",
			:wide_line => "#bfdb89",							# Wide line under header
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
			:wide_line => "#FAB597",							# Wide line under header
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
