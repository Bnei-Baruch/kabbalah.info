require File.dirname(__FILE__) + '/../test_helper'
require 'placeholders_controller'

# Re-raise errors caught by the controller.
class PlaceholdersController; def rescue_action(e) raise e end; end

class PlaceholdersControllerTest < Test::Unit::TestCase
  fixtures :placeholders

  def setup
    @controller = PlaceholdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:placeholders)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_placeholder
    old_count = Placeholder.count
    post :create, :placeholder => { }
    assert_equal old_count+1, Placeholder.count
    
    assert_redirected_to placeholder_path(assigns(:placeholder))
  end

  def test_should_show_placeholder
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_placeholder
    put :update, :id => 1, :placeholder => { }
    assert_redirected_to placeholder_path(assigns(:placeholder))
  end
  
  def test_should_destroy_placeholder
    old_count = Placeholder.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Placeholder.count
    
    assert_redirected_to placeholders_path
  end
end
