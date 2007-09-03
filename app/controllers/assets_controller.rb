class AssetsController < ApplicationController
  # GET /assets
  # GET /assets.xml
  def index
  	@section_id = nil
  	@grand_parent_id = ''
  	if params[:section_id]
  		@section_id = params[:section_id]
  	end 
  	@section_id ||= Asset.sections(true)
  	@section_title = Section.get_title_by_id(@section_id) || "Unknown"
  	if params[:parent_id]
  		@parent_id = params[:parent_id]
  		@parent = Asset.find(@parent_id)
  		@grand_parent_id = @parent.parent.id if @parent.parent
		else
			@parent_id = 0
  	end
  	 
    @assets = Asset.find(:all,
    	 									 :conditions => ["section_id = ? AND parent_id = ?", 
    	 									 								 @section_id, @parent_id], :order => "position ASC")
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @assets.to_xml }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @asset.to_xml }
    end
  end

  # GET /assets/new
  def new
#  	render :text => params[:asset][:asset_type]
  asset = params[:asset]
	type = asset[:asset_type]
	eval "redirect_to new_#{type}_path(
					:section_id => #{asset[:section_id]},
					:parent_id => #{asset[:parent_id].blank? ? 'nil' : asset[:parent_id]})"
  end

  # GET /assets/1;edit
  def edit
    @asset = Asset.find(params[:id])
    type = @asset.resource_type.downcase
    resource = @asset.resource
  		eval "redirect_to edit_#{type}_url(resource)"
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        flash[:notice] = 'Asset was successfully created.'
        format.html { redirect_to asset_url(@asset) }
        format.xml  { head :created, :location => asset_url(@asset) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors.to_xml }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = 'Asset was successfully updated.'
        format.html { redirect_to asset_url(@asset) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors.to_xml }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
