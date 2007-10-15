class CustomPreviewsController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /custom_previews
  # GET /custom_previews.xml
  def index
    @custom_previews = CustomPreview.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @custom_previews.to_xml }
    end
  end

  # GET /custom_previews/1
  # GET /custom_previews/1.xml
  def show
    @custom_preview = CustomPreview.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @custom_preview.to_xml }
    end
  end

  # GET /custom_previews/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @custom_preview = CustomPreview.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /custom_previews/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @custom_preview = CustomPreview.find(params[:id])
		edit_objects(@custom_preview) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /custom_previews
  # POST /custom_previews.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @custom_preview = CustomPreview.new(params[:custom_preview])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @custom_preview) ### Add to all resources
  end

  # PUT /custom_previews/1
  # PUT /custom_previews/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @custom_preview = CustomPreview.find(params[:id])
    update_objects(@custom_preview, params[:custom_preview]) ### Add to all resources
  end

  # DELETE /custom_previews/1
  # DELETE /custom_previews/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @custom_preview = CustomPreview.find(params[:id])
    @custom_preview.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
