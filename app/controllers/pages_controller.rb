class PagesController < ResourcesController
	
	layout "resource"
	
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @pages.to_xml }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @page.to_xml }
    end
  end

  # GET /pages/new
  def new
    @page = Page.new
    
		create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # GET /pages/1;edit
  def edit
    @page = Page.find_by_permalink(params[:id])
		edit_objects(@page) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    create_new_objects(:property => params[:property], 
    									 :image_storage => params[:image_storage], 
    									 :asset => params[:asset], 
    									 :resource => @page) ### Add to all resources
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find_by_permalink(params[:id])
    update_objects(@page, params[:page]) ### Add to all resources
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find_by_permalink(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  protected

end
