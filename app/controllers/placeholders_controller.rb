class PlaceholdersController < ApplicationController
  # GET /placeholders
  # GET /placeholders.xml
  def index
    @placeholders = Placeholder.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @placeholders.to_xml }
    end
  end

  # GET /placeholders/1
  # GET /placeholders/1.xml
  def show
    @placeholder = Placeholder.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @placeholder.to_xml }
    end
  end

  # GET /placeholders/new
  def new
    @placeholder = Placeholder.new
  end

  # GET /placeholders/1;edit
  def edit
    @placeholder = Placeholder.find(params[:id])
  end

  # POST /placeholders
  # POST /placeholders.xml
  def create
    @placeholder = Placeholder.new(params[:placeholder])

    respond_to do |format|
      if @placeholder.save
        flash[:notice] = 'Placeholder was successfully created.'
        format.html { redirect_to placeholder_url(@placeholder) }
        format.xml  { head :created, :location => placeholder_url(@placeholder) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @placeholder.errors.to_xml }
      end
    end
  end

  # PUT /placeholders/1
  # PUT /placeholders/1.xml
  def update
    @placeholder = Placeholder.find(params[:id])

    respond_to do |format|
      if @placeholder.update_attributes(params[:placeholder])
        flash[:notice] = 'Placeholder was successfully updated.'
        format.html { redirect_to placeholder_url(@placeholder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @placeholder.errors.to_xml }
      end
    end
  end

  # DELETE /placeholders/1
  # DELETE /placeholders/1.xml
  def destroy
    @placeholder = Placeholder.find(params[:id])
    @placeholder.destroy

    respond_to do |format|
      format.html { redirect_to placeholders_url }
      format.xml  { head :ok }
    end
  end
end
