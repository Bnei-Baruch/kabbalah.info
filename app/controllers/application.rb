# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_engkab_session_id'
  helper :path

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
