# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

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
	                       :theme_advanced_buttons1 => %w{formatselect bold italic underline separator justifyleft justifycenter justifyright indent outdent separator ltr rtl separator bullist numlist },
	                       :theme_advanced_buttons2 => %w{ code fullscreen separator undo redo separator search separator pastetext pasteword selectall separator anchor link unlink image separator removeformat },
	                       :theme_advanced_buttons3 => [],
	                       :plugins => %w{contextmenu paste fullscreen inlinepopups directionality searchreplace}},
	          :only => [:new, :edit, :show, :index])

	def redirect_to(options = {}, *parameters_for_method_reference)
		if (options.class == Hash) && (options.include? :type)
			if options.include? :resource
				super self.send(options[:type], options[:resource])
			else
				type = options[:type]
				options.delete :type
				super self.send(type, options)
			end
		else
			super options, *parameters_for_method_reference
		end
	end

end
