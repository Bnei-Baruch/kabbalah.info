class SectionPreviewsController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /section_previews
  # GET /section_previews.xml
  def index
    @section_previews = SectionPreview.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @section_previews.to_xml }
    end
  end

  # GET /section_previews/1
  # GET /section_previews/1.xml
  def show
    @section_preview = SectionPreview.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @section_preview.to_xml }
    end
  end

  # GET /section_previews/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @section_preview = SectionPreview.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /section_previews/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @section_preview = SectionPreview.find(params[:id])
		edit_objects(@section_preview) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /section_previews
  # POST /section_previews.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @section_preview = SectionPreview.new(params[:section_preview])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @section_preview) ### Add to all resources
  end

  # PUT /section_previews/1
  # PUT /section_previews/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @section_preview = SectionPreview.find(params[:id])
    update_objects(@section_preview, params[:section_preview]) ### Add to all resources
  end

  # DELETE /section_previews/1
  # DELETE /section_previews/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @section_preview = SectionPreview.find(params[:id])
    @section_preview.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
