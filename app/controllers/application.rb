# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  # To set :host for Mailer
  around_filter :retardase_inhibitor

  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_engkab_session_id'
  helper :path

  uses_tiny_mce(:options => {:theme => 'advanced',
	                       :browsers => %w{msie gecko},
	                       :width => "450",
	                       :inline_styles => "true",
	                       :editor_deselector => "mceNoEditor",
	                       :content_css => "/public/stylesheets/general.css",
	                       :theme_advanced_toolbar_location => "top",
	                       :theme_advanced_toolbar_align => "left",
	                       :theme_advanced_resizing => true,
	                       :theme_advanced_resize_horizontal => true,
	                       :paste_auto_cleanup_on_paste => true,
	                       :extended_valid_elements => "a[name|href|target|title|onclick]",
	                       :theme_advanced_buttons1 => %w{ bold italic underline separator justifyleft justifycenter justifyright indent outdent separator ltr rtl separator bullist numlist },
	                       :theme_advanced_buttons2 => %w{ code fullscreen separator undo redo separator search separator pastetext pasteword selectall separator anchor link unlink image separator removeformat },
	                       :theme_advanced_buttons3 => [],
	                       :plugins => %w{contextmenu paste fullscreen inlinepopups directionality searchreplace}},
	          :only => [:new, :edit, :show, :index])

    alias_method :orig_redirect_to, :redirect_to
	def section_homepage_url(section)
		homepage = Asset.find_by_section_id_and_resource_type(section.id,'Homepage')
		if homepage
			site_page0_url(:section => section)
		else
			categories = Asset.find(:all, :conditions => "section_id = #{section.id}  and resource_type = 'Category'", :order => 'position ASC')
			#in case the page is in category - like in vod
			if categories 
				first_category = categories.select{|cat| cat.category_has_published_page?}.first
			else
				first_category = nil
			end
			if first_category
				first_page = first_category.children.select{|asset| asset.is_page? && asset.published_page?}.sort{|a, b| a.position <=> b.position}.first
			#in case the section doesn't have categories - like in new to kabbalah
			else
				first_page = section.assets.select{|page| page.is_page? && page.parent_id == 0 && page.published_page?}.sort{|a, b| a.position <=> b.position}.first
			end 
			site_page0_url(:section => section, :id => first_page.resource)
		end
	end
	def redirect_to(options = {}, *parameters_for_method_reference)
		if (options.class == Symbol) && (options == :unauthorized)
            orig_redirect_to login_home_url, :status => 401
		elsif (options.class == Hash) && (options.include? :type)
          if options.include? :resource
            orig_redirect_to self.send(options[:type], options[:resource])
          else
            type = options[:type]
            options.delete :type
            orig_redirect_to self.send(type, options)
          end
		else
			orig_redirect_to options, *parameters_for_method_reference
		end
	end

end
