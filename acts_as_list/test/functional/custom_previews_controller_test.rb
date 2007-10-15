require File.dirname(__FILE__) + '/../test_helper'
require 'custom_previews_controller'

# Re-raise errors caught by the controller.
class CustomPreviewsController; def rescue_action(e) raise e end; end

class CustomPreviewsControllerTest < Test::Unit::TestCase
  fixtures :custom_previews

  def setup
    @controller = CustomPreviewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:custom_previews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_custom_preview
    old_count = CustomPreview.count
    post :create, :custom_preview => { }
    assert_equal old_count+1, CustomPreview.count
    
    assert_redirected_to custom_preview_path(assigns(:custom_preview))
  end

  def test_should_show_custom_preview
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_custom_preview
    put :update, :id => 1, :custom_preview => { }
    assert_redirected_to custom_preview_path(assigns(:custom_preview))
  end
  
  def test_should_destroy_custom_preview
    old_count = CustomPreview.count
    delete :destroy, :id => 1
    assert_equal old_count-1, CustomPreview.count
    
    assert_redirected_to custom_previews_path
  end
end
