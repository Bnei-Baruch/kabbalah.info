class PicturesController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = Picture.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @pictures.to_xml }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @picture.to_xml }
    end
  end

  # GET /pictures/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @picture = Picture.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /pictures/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @picture = Picture.find(params[:id])
		edit_objects(@picture) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @picture = Picture.new(params[:picture])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @picture) ### Add to all resources
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @picture = Picture.find(params[:id])
    update_objects(@picture, params[:picture]) ### Add to all resources
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
