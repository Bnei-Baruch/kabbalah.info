class VideosController < ApplicationController
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
  end

  # GET /videos/1;edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to video_url(@video) }
        format.xml  { head :created, :location => video_url(@video) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors.to_xml }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to video_url(@video) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors.to_xml }
      end
    end
  end
	def thumbnail
    @video = Video.find(params[:id])

		send_data @video.thumbnail, :type => @video.thumbnail_content_type, :disposition => 'inline'
	end
  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.xml  { head :ok }
    end
  end
end
