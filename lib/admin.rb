module Admin

protected
	def secret_password_change_function(user = nil, password = nil)
		if user == nil
			print "Unable to change password to an unknown user"
			return
		end
		if password == nil
			print "Unable to change #{user}'s password to the supplied one"
			return
		end
		user = User.find_by_login(user)
		user.password = password
		user.password_confirmation = password
		user.save!
	rescue Exception => exception
			"#{exception.class} (#{exception.message})"
	end

  def param_by_pattern(pattern)
		keys = params.keys.grep(/^#{pattern}/)
    return nil if keys.blank?
    params[keys[0]]
  end

end
