class SectionsController < ApplicationController
  # GET /sections
  # GET /sections.xml
  def index
    @sections = Section.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @sections.to_xml }
    end
  end

  # GET /sections/1
  # GET /sections/1.xml
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @section.to_xml }
    end
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1;edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to section_url(@section) }
        format.xml  { head :created, :location => section_url(@section) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors.to_xml }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to section_url(@section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors.to_xml }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url }
      format.xml  { head :ok }
    end
  end
end
