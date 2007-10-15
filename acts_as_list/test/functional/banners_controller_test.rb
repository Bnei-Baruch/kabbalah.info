require File.dirname(__FILE__) + '/../test_helper'
require 'banners_controller'

# Re-raise errors caught by the controller.
class BannersController; def rescue_action(e) raise e end; end

class BannersControllerTest < Test::Unit::TestCase
  fixtures :banners

  def setup
    @controller = BannersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:banners)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_banner
    old_count = Banner.count
    post :create, :banner => { }
    assert_equal old_count+1, Banner.count
    
    assert_redirected_to banner_path(assigns(:banner))
  end

  def test_should_show_banner
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_banner
    put :update, :id => 1, :banner => { }
    assert_redirected_to banner_path(assigns(:banner))
  end
  
  def test_should_destroy_banner
    old_count = Banner.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Banner.count
    
    assert_redirected_to banners_path
  end
end
