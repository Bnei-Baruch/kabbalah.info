class AssetsController < ApplicationController

  # POST /assets/1;sort_by_parent_id
  def sort_by_parent_id(do_render = true)
    if !has_right?(:edit)
      redirect_to :unauthorized and return
    end
    parent_id = params[:id]
    section_id = params[:section_id]
    placeholder_id = params[:placeholder_id]
    resources = Asset.find_all_by_parent_id_and_section_id_and_placeholder_id(
                        parent_id,
                        section_id,
                        placeholder_id)
		list = params["assets-list#{parent_id}-#{section_id}-#{placeholder_id}"]
    resources.each do |resource|
    	index = list.index(resource.id.to_s)
    	resource.position = index ? index + 1 : 1
    	resource.save
  	end
    # We're not going to move something
    (render :nothing => true and return) if do_render
  end

  # POST /assets/1;sort_sections
  def sort_by_parent_id
    if !has_right?(:edit)
      redirect_to :unauthorized and return
    end
    resources = Section.environments(false,true)
		list = params["assets-list0"]
    resources.each do |resource|
    	index = list.index(resource.id.to_s)
    	resource.position = index ? index + 1 : 1
    	resource.save
  	end
    # We're not going to move something
    render :nothing => true and return
  end

  # POST /assets/1;sort
  def sort
    sort_by_parent_id(false)

    # Re-render middle part
    parent_id = params[:id]
    section_id = params[:section_id]
    placeholder_id = params[:placeholder_id]
    resources = Asset.find_all_by_parent_id_and_section_id_and_placeholder_id(
                        parent_id,
                        section_id,
                        placeholder_id,
                        :order => 'position ASC')
    @page = Asset.find(parent_id)
    @section = @page.section
		assets = render_to_string :partial => "engkab/show_assets_in_loop",
					 :locals => { :container => resources, :display => "show" }
		navigation = render_to_string :partial => "engkab/general/next_prev_navigation_in_category"
    render :update do |page|
      page.replace_html 'assets', assets
      page.insert_html :bottom, 'assets', navigation if (not navigation.blank?)
    end and return
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
