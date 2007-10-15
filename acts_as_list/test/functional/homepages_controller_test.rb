require File.dirname(__FILE__) + '/../test_helper'
require 'homepages_controller'

# Re-raise errors caught by the controller.
class HomepagesController; def rescue_action(e) raise e end; end

class HomepagesControllerTest < Test::Unit::TestCase
  fixtures :homepages

  def setup
    @controller = HomepagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:homepages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_homepage
    old_count = Homepage.count
    post :create, :homepage => { }
    assert_equal old_count+1, Homepage.count
    
    assert_redirected_to homepage_path(assigns(:homepage))
  end

  def test_should_show_homepage
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_homepage
    put :update, :id => 1, :homepage => { }
    assert_redirected_to homepage_path(assigns(:homepage))
  end
  
  def test_should_destroy_homepage
    old_count = Homepage.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Homepage.count
    
    assert_redirected_to homepages_path
  end
end
