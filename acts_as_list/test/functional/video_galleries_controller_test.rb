require File.dirname(__FILE__) + '/../test_helper'
require 'video_galleries_controller'

# Re-raise errors caught by the controller.
class VideoGalleriesController; def rescue_action(e) raise e end; end

class VideoGalleriesControllerTest < Test::Unit::TestCase
  fixtures :video_galleries

  def setup
    @controller = VideoGalleriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:video_galleries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_video_gallery
    old_count = VideoGallery.count
    post :create, :video_gallery => { }
    assert_equal old_count+1, VideoGallery.count
    
    assert_redirected_to video_gallery_path(assigns(:video_gallery))
  end

  def test_should_show_video_gallery
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_video_gallery
    put :update, :id => 1, :video_gallery => { }
    assert_redirected_to video_gallery_path(assigns(:video_gallery))
  end
  
  def test_should_destroy_video_gallery
    old_count = VideoGallery.count
    delete :destroy, :id => 1
    assert_equal old_count-1, VideoGallery.count
    
    assert_redirected_to video_galleries_path
  end
end
