class BannersController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /banners
  # GET /banners.xml
  def index
    @banners = Banner.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @banners.to_xml }
    end
  end

  # GET /banners/1
  # GET /banners/1.xml
  def show
    @banner = Banner.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @banner.to_xml }
    end
  end

  # GET /banners/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @banner = Banner.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /banners/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @banner = Banner.find(params[:id])
		edit_objects(@banner) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /banners
  # POST /banners.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @banner = Banner.new(params[:banner])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @banner) ### Add to all resources
  end

  # PUT /banners/1
  # PUT /banners/1.xml
  def update
		params[:banner][:section_ids] ||= []
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @banner = Banner.find(params[:id])
    update_objects(@banner, params[:banner]) ### Add to all resources
  end

  # DELETE /banners/1
  # DELETE /banners/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
