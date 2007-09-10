class ArticlesController < ResourcesController
  layout "resource" ### Add to all resources
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @articles.to_xml }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @article.to_xml }
    end
  end

  # GET /articles/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @article = Article.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # GET /articles/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @article = Article.find(params[:id])
		edit_objects(@article) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /articles
  # POST /articles.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @article = Article.new(params[:article])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @article) ### Add to all resources
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @article = Article.find(params[:id])
    update_objects(@article, params[:article]) ### Add to all resources
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.xml  { head :ok }
    end
  end
end
