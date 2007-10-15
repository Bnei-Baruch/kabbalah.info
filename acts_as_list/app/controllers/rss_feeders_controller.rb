class RssFeedersController < ResourcesController

  layout "resource" ### Add to all resources

  # GET /rss_feeders
  # GET /rss_feeders.xml
  def index
    @rss_feeders = RssFeeder.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @rss_feeders.to_xml }
    end
  end

  # GET /rss_feeders/1
  # GET /rss_feeders/1.xml
  def show
    @rss_feeder = RssFeeder.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @rss_feeder.to_xml }
    end
  end

  # GET /rss_feeders/new
  def new
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @rss_feeder = RssFeeder.new
    create_new_objects() ### Add to all resources
    save_refferer_to_session() ### Add to all resources
 end

  # GET /rss_feeders/1;edit
  def edit
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @rss_feeder = RssFeeder.find(params[:id])
		edit_objects(@rss_feeder) ### Add to all resources
    save_refferer_to_session() ### Add to all resources
  end

  # POST /rss_feeders
  # POST /rss_feeders.xml
  def create
    if !has_right?(:create)
      redirect_to :unauthorized
      return
    end
    @rss_feeder = RssFeeder.new(params[:rss_feeder])
    create_new_objects(:property => params[:property],
    									 :image_storage => params[:image_storage],
    									 :asset => params[:asset],
    									 :resource => @rss_feeder) ### Add to all resources
  end

  # PUT /rss_feeders/1
  # PUT /rss_feeders/1.xml
  def update
    if !has_right?(:edit)
      redirect_to :unauthorized
      return
    end
    @rss_feeder = RssFeeder.find(params[:id])
    update_objects(@rss_feeder, params[:rss_feeder]) ### Add to all resources
  end

  # DELETE /rss_feeders/1
  # DELETE /rss_feeders/1.xml
  def destroy
    if !has_right?(:delete)
      redirect_to :unauthorized
      return
    end
    @rss_feeder = RssFeeder.find(params[:id])
    @rss_feeder.destroy

    respond_to do |format|
      format.html { redirect_to :back } ### Add to all resources
      format.xml  { head :ok }
    end
  end

end
