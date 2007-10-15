require File.dirname(__FILE__) + '/../test_helper'
require 'section_previews_controller'

# Re-raise errors caught by the controller.
class SectionPreviewsController; def rescue_action(e) raise e end; end

class SectionPreviewsControllerTest < Test::Unit::TestCase
  fixtures :section_previews

  def setup
    @controller = SectionPreviewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:section_previews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_section_preview
    old_count = SectionPreview.count
    post :create, :section_preview => { }
    assert_equal old_count+1, SectionPreview.count
    
    assert_redirected_to section_preview_path(assigns(:section_preview))
  end

  def test_should_show_section_preview
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_section_preview
    put :update, :id => 1, :section_preview => { }
    assert_redirected_to section_preview_path(assigns(:section_preview))
  end
  
  def test_should_destroy_section_preview
    old_count = SectionPreview.count
    delete :destroy, :id => 1
    assert_equal old_count-1, SectionPreview.count
    
    assert_redirected_to section_previews_path
  end
end
