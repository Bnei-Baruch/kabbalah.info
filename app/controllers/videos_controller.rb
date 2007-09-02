class VideosController < ResourcesController
	
	layout "resource" ### Add to all resources
	
  # GET /videos
  # GET /videos.xml
  def index
    @videos = Video.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @videos.to_xml }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @video.to_xml }
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /videos/1;edit
  def edit
    @video = Video.find(params[:id])
		edit_objects(@video) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])
    create_new_objects(:property => params[:property], 
    									 :image_storage => params[:image_storage], 
    									 :asset => params[:asset], 
    									 :resource => @video) ### Add to all resources
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])
    update_objects(@video, params[:video]) ### Add to all resources
  end
  
  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end
  
end
