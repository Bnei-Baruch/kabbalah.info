class PagesController < ResourcesController
uses_tiny_mce(:options => {:theme => 'advanced',
                           :browsers => %w{msie gecko},
                           :width => "450",
                           :inline_styles => "true",
                           :editor_deselector => "mceNoEditor",
                           :content_css => "/public/stylesheets/general.css",
                           :theme_advanced_toolbar_location => "top",
                           :theme_advanced_toolbar_align => "left",
                           :theme_advanced_resizing => true,
                           :theme_advanced_resize_horizontal => true,
                           :paste_auto_cleanup_on_paste => true,
                           :extended_valid_elements => "a[name|href|target|title|onclick]",
                           :theme_advanced_buttons1 => %w{formatselect bold italic underline separator justifyleft justifycenter justifyright indent outdent separator ltr rtl separator bullist numlist },
                           :theme_advanced_buttons2 => %w{ code fullscreen separator undo redo separator search separator pastetext pasteword selectall separator anchor link unlink image separator removeformat },
                           :theme_advanced_buttons3 => [],
                           :plugins => %w{contextmenu paste fullscreen inlinepopups directionality searchreplace}},
              :only => [:new, :edit, :show, :index])
              	
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
