require File.dirname(__FILE__) + '/../test_helper'
require 'picture_galleries_controller'

# Re-raise errors caught by the controller.
class PictureGalleriesController; def rescue_action(e) raise e end; end

class PictureGalleriesControllerTest < Test::Unit::TestCase
  fixtures :picture_galleries

  def setup
    @controller = PictureGalleriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:picture_galleries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_picture_gallery
    old_count = PictureGallery.count
    post :create, :picture_gallery => { }
    assert_equal old_count+1, PictureGallery.count
    
    assert_redirected_to picture_gallery_path(assigns(:picture_gallery))
  end

  def test_should_show_picture_gallery
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_picture_gallery
    put :update, :id => 1, :picture_gallery => { }
    assert_redirected_to picture_gallery_path(assigns(:picture_gallery))
  end
  
  def test_should_destroy_picture_gallery
    old_count = PictureGallery.count
    delete :destroy, :id => 1
    assert_equal old_count-1, PictureGallery.count
    
    assert_redirected_to picture_galleries_path
  end
end
