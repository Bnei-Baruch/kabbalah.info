class AssetsController < ApplicationController

  # POST /assets/1;sort_by_parent_id
  def sort_by_parent_id(do_render = true)
    (redirect_to :unauthorized and return) unless has_right?(:edit)

    #should throw an exception if the following three attributes don't present
    @parent_id = params[:id] || 0
    @section_id = params[:section_id] || 0
    @placeholder_id = params[:placeholder_id] || 0
    resources = Asset.find_all_by_parent_id_and_section_id_and_placeholder_id(
                        @parent_id,
                        @section_id,
                        @placeholder_id,
                        :order => 'position ASC'
                )
		list = params[sort_ul_id(@parent_id, @section_id, @placeholder_id)]
		order = params[:order] || "ASC"
    
    # On Homepage assets may be moved between placeholders
    # Will take care only on addition to a target list, not on
    # subtraction from a source one
    if resources.size < list.size
      # Find out a new asset and move it to this placeholder
      # Then call sort_by_parent_id again

      assets = resources.map{|r| r.id.to_s}
      new_one = (list - assets)[0]
      asset = Asset.find(new_one.to_i)
      asset.placeholder_id = @placeholder_id
      asset.save

      sort_by_parent_id
      return
    end
		#debugger
    reindex resources, list, order

    (render :nothing => true and return) if do_render
  end

  # POST /assets/1;sort_sections
  def sort_sections
    (redirect_to :unauthorized and return) unless has_right?(:edit)

    resources = Section.environments(false,true)
    list = params[sort_ul_id(0, 0, 0)]
    reindex resources, list

    render :nothing => true and return
  end

  # POST /assets/1;sort
  def sort
    (redirect_to :unauthorized and return) unless has_right?(:edit)
    	
    sort_by_parent_id(false)

    # Re-render middle part
    resources = Asset.find_all_by_parent_id_and_section_id_and_placeholder_id(
                        @parent_id,
                        @section_id,
                        @placeholder_id,
                        :order => 'position ASC')
    @page = Asset.find(@parent_id)
    @section = @page.section
    order = params[:order] || "ASC"	
    
		assets = render_to_string :partial => "engkab/show_assets_in_loop",
					 :locals => { :container => resources, :display => "show", :order => order }
					 
		navigation = render_to_string :partial => "engkab/general/next_prev_navigation_in_category"
    render :update do |page|
      page.replace_html 'assets', assets
      page.insert_html :bottom, 'assets', navigation unless navigation.blank?
    end and return
  end

  # GET /assets
  # GET /assets.xml
  def index
		@section_id = param_by_pattern('section_id')
		@section = Section.find(@section_id)
  	@grand_parent_id = ''
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

#    respond_to do |format|
#      format.html # index.rhtml
#      format.xml  { render :xml => @assets.to_xml }
#    end
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
    type = param_by_pattern('asset_type')
    classes = param_by_pattern('classes')
    my_class = classes ? YAML.load(classes)[type.to_sym] : ''
		section_id = param_by_pattern('section_id')
		placeholder_id = param_by_pattern('placeholder_id')
		parent_id = param_by_pattern('parent_id')

    redirect_to :type => "new_#{type}_path",
					:section_id => section_id,
					:placeholder_id => placeholder_id,
					:parent_id => parent_id,
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

  protected

  def reindex(resources, list, order = 'ASC')  
  	if order == 'DESC'
  		list.reverse!
  	end
    resources.each do |resource|
      index = list.index(resource.id.to_s).to_i
      index += 1
      if resource.position != index
        resource.position = index
        resource.save
      end
    end
  end

end
