class ResourcesController < ApplicationController

  session :off, :except => %w(new edit create update)
	after_filter :save_refferer_to_session, :only => [ :new, :edit ]

protected

	def save_refferer_to_session
    session[:referer] = request.env["HTTP_REFERER"]
	end

	def create_new_asset(hash = nil)
		if hash == nil
	    @asset = Asset.new(:section_id => params[:section_id],
	    									 :parent_id => params[:parent_id])
		else
	    @asset = Asset.new(hash[:args])
	    @asset.resource = hash[:resource]
		end
	end
end
