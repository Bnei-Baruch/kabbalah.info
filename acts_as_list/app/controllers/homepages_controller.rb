class HomepagesController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /homepages
  # GET /homepages.xml
  def index
    @homepages = Homepage.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @homepages.to_xml }
    end
  end

  # GET /homepages/1
  # GET /homepages/1.xml
  def show
    @homepage = Homepage.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @homepage.to_xml }
    end
  end

  # GET /homepages/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @homepage = Homepage.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /homepages/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @homepage = Homepage.find(params[:id])
		edit_objects(@homepage) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /homepages
  # POST /homepages.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @homepage = Homepage.new(params[:homepage])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @homepage) ### Add to all resources
  end

  # PUT /homepages/1
  # PUT /homepages/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @homepage = Homepage.find(params[:id])
    update_objects(@homepage, params[:homepage]) ### Add to all resources
  end

  # DELETE /homepages/1
  # DELETE /homepages/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @homepage = Homepage.find(params[:id])
    @homepage.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
