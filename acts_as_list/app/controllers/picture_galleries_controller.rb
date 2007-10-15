class PictureGalleriesController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /picture_galleries
  # GET /picture_galleries.xml
  def index
    @picture_galleries = PictureGallery.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @picture_galleries.to_xml }
    end
  end

  # GET /picture_galleries/1
  # GET /picture_galleries/1.xml
  def show
    @picture_gallery = PictureGallery.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @picture_gallery.to_xml }
    end
  end

  # GET /picture_galleries/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @picture_gallery = PictureGallery.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /picture_galleries/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @picture_gallery = PictureGallery.find(params[:id])
		edit_objects(@picture_gallery) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /picture_galleries
  # POST /picture_galleries.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @picture_gallery = PictureGallery.new(params[:picture_gallery])
    create_new_objects(:property => params[:property],
    									 :picture_storage => params[:picture_storage],
    									 :asset => params[:asset],
    									 :resource => @picture_gallery) ### Add to all resources
  end

  # PUT /picture_galleries/1
  # PUT /picture_galleries/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @picture_gallery = PictureGallery.find(params[:id])
    update_objects(@picture_gallery, params[:picture_gallery]) ### Add to all resources
  end

  # DELETE /picture_galleries/1
  # DELETE /picture_galleries/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @picture_gallery = PictureGallery.find(params[:id])
    @picture_gallery.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
