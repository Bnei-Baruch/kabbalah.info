require File.dirname(__FILE__) + '/../test_helper'
require 'engkabs_controller'

# Re-raise errors caught by the controller.
class EngkabsController; def rescue_action(e) raise e end; end

class EngkabsControllerTest < Test::Unit::TestCase
  fixtures :engkabs

  def setup
    @controller = EngkabsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:engkabs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_engkab
    old_count = Engkab.count
    post :create, :engkab => { }
    assert_equal old_count+1, Engkab.count
    
    assert_redirected_to engkab_path(assigns(:engkab))
  end

  def test_should_show_engkab
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_engkab
    put :update, :id => 1, :engkab => { }
    assert_redirected_to engkab_path(assigns(:engkab))
  end
  
  def test_should_destroy_engkab
    old_count = Engkab.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Engkab.count
    
    assert_redirected_to engkabs_path
  end
end
