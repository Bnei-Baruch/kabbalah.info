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
    create_new_asset()
  end

  # GET /categories/1;edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
    create_new_asset(:args => params[:asset], :resource => @category)

    respond_to do |format|
      if @category.valid?
      	@asset.save!
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to session[:referer] }
        format.xml  { head :created, :location => category_url(@category) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors.to_xml }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to session[:referer] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors.to_xml }
      end
    end
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
