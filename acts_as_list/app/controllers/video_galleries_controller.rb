class VideoGalleriesController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /video_galleries
  # GET /video_galleries.xml
  def index
    @video_galleries = VideoGallery.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @video_galleries.to_xml }
    end
  end

  # GET /video_galleries/1
  # GET /video_galleries/1.xml
  def show
    @video_gallery = VideoGallery.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @video_gallery.to_xml }
    end
  end

  # GET /video_galleries/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @video_gallery = VideoGallery.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /video_galleries/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @video_gallery = VideoGallery.find(params[:id])
		edit_objects(@video_gallery) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /video_galleries
  # POST /video_galleries.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @video_gallery = VideoGallery.new(params[:video_gallery])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @video_gallery) ### Add to all resources
  end

  # PUT /video_galleries/1
  # PUT /video_galleries/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @video_gallery = VideoGallery.find(params[:id])
    update_objects(@video_gallery, params[:video_gallery]) ### Add to all resources
  end

  # DELETE /video_galleries/1
  # DELETE /video_galleries/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @video_gallery = VideoGallery.find(params[:id])
    @video_gallery.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
