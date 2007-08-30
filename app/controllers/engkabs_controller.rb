class EngkabsController < ApplicationController
  # GET /engkabs
  # GET /engkabs.xml
  def index
    @engkabs = Engkab.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @engkabs.to_xml }
    end
  end

  # GET /engkabs/1
  # GET /engkabs/1.xml
  def show
    @engkab = Engkab.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @engkab.to_xml }
    end
  end

  # GET /engkabs/new
  def new
    @engkab = Engkab.new
  end

  # GET /engkabs/1;edit
  def edit
    @engkab = Engkab.find(params[:id])
  end

  # POST /engkabs
  # POST /engkabs.xml
  def create
    @engkab = Engkab.new(params[:engkab])

    respond_to do |format|
      if @engkab.save
        flash[:notice] = 'Engkab was successfully created.'
        format.html { redirect_to engkab_url(@engkab) }
        format.xml  { head :created, :location => engkab_url(@engkab) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @engkab.errors.to_xml }
      end
    end
  end

  # PUT /engkabs/1
  # PUT /engkabs/1.xml
  def update
    @engkab = Engkab.find(params[:id])

    respond_to do |format|
      if @engkab.update_attributes(params[:engkab])
        flash[:notice] = 'Engkab was successfully updated.'
        format.html { redirect_to engkab_url(@engkab) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @engkab.errors.to_xml }
      end
    end
  end

  # DELETE /engkabs/1
  # DELETE /engkabs/1.xml
  def destroy
    @engkab = Engkab.find(params[:id])
    @engkab.destroy

    respond_to do |format|
      format.html { redirect_to engkabs_url }
      format.xml  { head :ok }
    end
  end
end
