class LinksController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /links
  # GET /links.xml
  def index
    @links = Link.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @links.to_xml }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @link.to_xml }
    end
  end

  # GET /links/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @link = Link.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /links/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @link = Link.find(params[:id])
		edit_objects(@link) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /links
  # POST /links.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @link = Link.new(params[:link])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @link) ### Add to all resources
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @link = Link.find(params[:id])
    update_objects(@link, params[:link]) ### Add to all resources
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
