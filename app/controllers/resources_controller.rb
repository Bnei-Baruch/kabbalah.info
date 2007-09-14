class ResourcesController < ApplicationController

	after_filter :save_refferer_to_session, :only => [ :new, :edit ]

  protected

	def save_refferer_to_session
      session[:referer] = request.env["HTTP_REFERER"]
	end

	def create_new_objects(options = nil)
		if options == nil
			@property = Property.new
			@image_storage = ImageStorage.new
	        @asset = Asset.new(:section_id => params[:section_id],
	    									 		 :placeholder_id => params[:placeholder_id],
	    									 		 :parent_id => params[:parent_id])	    									 		 
		else
			resource = options[:resource]
			resource_type = resource.class.to_s.downcase
			@property = Property.new(options[:property])
			@image_storage = ImageStorage.new(options[:image_storage])
			@property.image_storage = @image_storage
			resource.property = @property

	    @asset = Asset.new(options[:asset])
	    @asset.resource = resource

      respond_to do |format|
	      if resource.valid? && @property.valid? &&
	      	(params[:image_storage][:uploaded_data].blank? ? true : @image_storage.valid?)

	      	@asset.save!
	        flash[:notice] = "#{resource_type} was successfully created."
	        format.html { redirect_to session[:referer] }
	        eval("format.xml  { head :created, :location => #{resource_type}_url(resource) }")
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => resource.errors.to_xml }
	      end
	    end

		end
	end

	def update_objects(resource, resource_params)
				@property = resource.property

    if (@property.image_storage == nil) && (not params[:image_storage][:uploaded_data].blank?)
    	@image_storage = ImageStorage.new(params[:image_storage])
			@property.image_storage = @image_storage
      if resource.valid? && @property.valid? && @image_storage.valid?
      	resource.save!
    	end
		else
			@image_storage = @property.image_storage
		end

    respond_to do |format|
      if resource.update_attributes(resource_params) &&
      	 @property.update_attributes(params[:property]) &&
      	 (params[:image_storage][:uploaded_data].blank? ? true : @image_storage.update_attributes(params[:image_storage]))

        flash[:notice] = "#{resource.class.to_s} was successfully updated."
        format.html { redirect_to session[:referer] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => resource.errors.to_xml }
      end
    end
	end

	def edit_objects(resource)
      @property = resource.property
      @property = Property.new unless @property
      @image_storage = (@property.image_storage if @property) || ImageStorage.new
	end
end
