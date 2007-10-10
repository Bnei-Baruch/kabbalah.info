class AssetsController < ApplicationController

  # POST /assets/1;sort
  def sort
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end

    @page = Asset.find(params[:id])
    resources = Asset.find_all_by_parent_id(@page.id)
		list = params["assets-list#{params[:id]}"]
    resources.each do |resource|
    	resource.position = list.index(resource.id.to_s) + 1
    	resource.save
  	end
		#render :nothing => true
    render :update do |page|
      page[:assets].replace_html :partial => "engkab/show_assets_in_loop",
						 :locals => { :container => resources, :display => "show" }
      #page[:assets].insert_html :bottom, 
             #:partial => "engkab/general/next_prev_navigation_in_category"
    end
    return

  end

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

	 store_location

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
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
	type = params[:asset_type].downcase
	my_class = params[:classes] ? YAML.load(params[:classes])[type.to_sym] : ''

	redirect_to :type => "new_#{type}_path",
					:section_id => params[:section_id],
					:placeholder_id => params[:placeholder_id].blank? ? 'nil' : params[:placeholder_id],
					:parent_id => params[:parent_id].blank? ? 'nil' : params[:parent_id],
					:my_class => my_class
  end

  # GET /assets/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @asset = Asset.find(params[:id])
    type = @asset.resource_type.tableize.singularize
		my_class = params[:classes] ? YAML.load(params[:classes])[type.to_sym] : ''
    resource = @asset.resource

		redirect_to :type => "edit_#{type}_path".downcase,
								:id => resource,
								:my_class => my_class
  end

  # POST /assets
  # POST /assets.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
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
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
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
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
