class CategoriesController < ResourcesController
	
	layout "resource"
	
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @categories.to_xml }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @category.to_xml }
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # GET /categories/1;edit
  def edit
    @category = Category.find(params[:id])
		edit_objects(@category) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
    create_new_objects(:property => params[:property], 
    									 :image_storage => params[:image_storage], 
    									 :asset => params[:asset], 
    									 :resource => @category) ### Add to all resources
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])
    update_objects(@category, params[:category]) ### Add to all resources
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
