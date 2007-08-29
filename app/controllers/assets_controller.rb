class AssetsController < ApplicationController
  # GET /assets
  # GET /assets.xml
  def index
  	@section_id = @parent_id = nil
  	if params[:asset] && params[:asset][:section_id]
  		@section_id = params[:asset][:section_id]
  	end 
  	@section_id ||= Asset.sections(true)
  	@section_title = Section.get_title_by_id(@section_id) || "Unknown"
  	if params[:asset] && params[:asset][:parent]
  		@parent_id = params[:asset][:parent_id]
  	end 
    @assets = Asset.find(:all,
    	 :conditions => ["section_id = ? AND parent_id = ?", @section_id, @parent_id])

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

	# case params[:asset][:asset_type]
	# when 'article'
	# 	redirect_to new_article_path
	# when 'video'
	# 	redirect_to new_video_path(:section_id => params[:asset][:section_id],
	# 														 :parent_id => params[:asset][:parent_id])
	# when 'category'
	# 	redirect_to new_video_path(:section_id => params[:asset][:section_id],
	# 														 :parent_id => params[:asset][:parent_id])
	# end
  end

  # GET /assets/1;edit
  def edit
    @asset = Asset.find(params[:id])
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
      format.html { redirect_to assets_url }
      format.xml  { head :ok }
    end
  end
end
